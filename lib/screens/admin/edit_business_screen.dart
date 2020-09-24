import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/services/admin_services.dart';
import 'package:gordos_pero_felizes/services/dropdown_items_getter.dart';
import 'package:gordos_pero_felizes/services/image_getter.dart';
import 'package:gordos_pero_felizes/widgets/business_editor.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/confirm_dialog.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/yes_no_dialog.dart';
import 'package:gordos_pero_felizes/widgets/loading_gif.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io';

/// This screen is used to change details about a business already in the system,
/// at this point everything can be changed except for images. We can only change
/// the main image and add images to the secondary images, not delete, if you
/// want to delete then you need to do that form firebase

class EditBusinessScreen extends StatefulWidget {
  static final String screenId = 'editBusinessScreen';

  @override
  _EditBusinessScreenState createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends State<EditBusinessScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// Drop down value, query and list for business chooser to edit
  String businessChooserStringValue;
  QuerySnapshot businessesQuerySnapshot;
  List<DropdownMenuItem> businessChooserDropDownList;

  /// Main image file and path
  File _mainImageFile;
  String mainImagePath;

  /// List of image assets for secondary images
  List<Asset> images = List<Asset>();

  /// Initial and final list of categories for this business, we need an initial
  /// and final list to make sure we remove this business from any category that
  /// is removed in the final, but is in the initial
  List<String> initialCategoryIDs = List<String>();
  List<String> finalCategoryIDs = List<String>();

  /// Business object used to move information between here and business edit screen
  Business business;

  /// Will download the business to be edited and its information be added to
  /// our local business object to then be sent to the business editor screen
  Future<void> updateValues() async {
    // grab business from db and set to local object
    await firebaseFirestore
        .collection(fk_businessCollection)
        .doc(businessChooserStringValue)
        .get()
        .then((DocumentSnapshot value) async {
      var reference = value.reference;
      business = await Business.getBusinessFromDB(reference);
      mainImagePath = business.mainImageAsset;

      // grab all categories that have this business associated
      QuerySnapshot query = await firebaseFirestore
          .collection(fk_categoryCollection)
          .where(fk_businesses, arrayContains: reference)
          .get();
      query.docs.forEach((element) {
        initialCategoryIDs.add(element.id);
        finalCategoryIDs.add(element.id);
      });
    });
  }

  /// Deals with updating the db
  Future<void> updateDB() async {
    // Main image path names and upload
    String imagePath;
    String initialPath = business.businessName.replaceAll(" ", "");
    _mainImageFile != null
        ? imagePath = await ImageGetter.uploadImage(
            image: _mainImageFile,
            imagePath: 'businesses/$initialPath/${initialPath}_main')
        : null;

    // Secondary images paths and upload
    List<String> paths;
    images.isNotEmpty
        ? paths = await AdminServices.uploadImages(
            images: images,
            businessName: business.businessName.replaceAll(" ", ""))
        : null;

    // Update business data if there is anything to update
    business.mainImageAsset = imagePath ?? business.mainImageAsset;
    business.imageAssetList.addAll(paths);

    // Upload business to db
    business.addBusinessToDB(firebaseFirestore);

    // Update categories
    // remove categorise that are in initial and are not in final
    var categoriesToDelete = initialCategoryIDs
        .where((element) => !finalCategoryIDs.contains(element));
    categoriesToDelete.forEach((element) async {
      business.removeFromCategory(element, firebaseFirestore);
    });

    // add the categories that are in final but where not in initial
    var categoriesToAdd = finalCategoryIDs
        .where((element) => !initialCategoryIDs.contains(element));
    categoriesToAdd.forEach((element) async {
      await business.addToCategory(element, firebaseFirestore);
    });
  }

  /// Grab all the businesses that can be edited and add them to our
  /// drop down list.
  @override
  void initState() {
    DropDownItemsGetter.getBusinesses(
        thenFinalFunction: (dropDownItems, querySnapshot) {
      businessesQuerySnapshot = querySnapshot;
      setState(() {
        businessChooserDropDownList = dropDownItems;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title widget with app padding
            Padding(
              padding: k_appPadding,
              child: TitleWidget(
                isImage: false,
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                mainText: 'Editar Negocio',
                textStyle: k_16wStyle,
              ),
            ),

            /// Business Chooser only if there hasnt been a business chosen
            businessChooserStringValue == null
                ? Column(
                    children: [
                      Text('Porfavor selecione un negocio a editar.'),

                      // Make sure there are items in the drop down list
                      businessChooserDropDownList != null
                          ? RedRoundedDropDown(
                              hint: 'Negocio',
                              value: businessChooserStringValue,
                              onChangeFunction: (value) async {
                                businessChooserStringValue = value;
                                await updateValues();
                                setState(() {});
                              },
                              dropDownItems: businessChooserDropDownList,
                            )
                          : LoadingGif(),
                    ],
                  )
                :

                /// Else we open the business editor
                Flexible(
                    fit: FlexFit.loose,
                    child: BusinessEditor(
                      categoryIDs: finalCategoryIDs,
                      business: business,

                      /// Submit text and function
                      finalButtonString: 'Cambiar Negocio',
                      finalOnTapFunction: () {
                        showDialog(
                          child: YesNoDialog(
                            dialogText:
                                'Seguro que queires cambiar este negocio?',
                            onNoFunction: () => Navigator.pop(context),
                            onYesFunction: () async {
                              Navigator.pop(context);
                              showDialog(context: context, child: LoadingGif());
                              updateDB().whenComplete(
                                () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    child: ConfirmDialog(
                                      text:
                                          'El negocio se ha cambiado correctamente!',
                                      onTapFunction: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          context: context,
                        );
                      },

                      /// Secondary Images
                      multiImageOnTapFunction: () async {
                        images = await ImageGetter.loadAssets();
                        return GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(
                            images.length,
                            (index) {
                              Asset asset = images[index];
                              return AssetThumb(
                                asset: asset,
                                width: 250,
                                height: 250,
                              );
                            },
                          ),
                        );
                      },

                      /// Main Image
                      mainImagePath: _mainImageFile?.path ?? mainImagePath,
                      isOnlineMainImage: _mainImageFile == null,
                      mainImageOnTapFunction: () async {
                        _mainImageFile = await ImageGetter.getImage().then(
                          (value) {
                            setState(() {});
                            return value;
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
