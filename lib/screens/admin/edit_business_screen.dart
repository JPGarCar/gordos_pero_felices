import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/services/dropdown_items_getter.dart';
import 'package:gordos_pero_felizes/services/image_getter.dart';
import 'package:gordos_pero_felizes/widgets/business_editor.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/confirm_dialog.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/yes_no_dialog.dart';
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
  String businessChooserStringValue;
  QuerySnapshot businessesQuerySnapshot;

  List<DropdownMenuItem> businessChooserDropDownList;

  bool isActive = true;
  int happyRating;
  int houseRating;
  int moneyRating;
  File _mainImageFile;
  String mainImagePath;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController favoriteDishesController = TextEditingController();
  TextEditingController gordoTipController = TextEditingController();
  TextEditingController igLinkController = TextEditingController();
  TextEditingController rappiLinkController = TextEditingController();
  TextEditingController uberEatsController = TextEditingController();

  List<Asset> images = List<Asset>();

  /// Deals with creating a single string separated by . from a list of strings
  String listToString(List<dynamic> list) {
    String compoundedText = '';
    for (String string in list) {
      compoundedText = compoundedText + string + '. ';
    }
    return compoundedText;
  }

  /// Deals with changing the controller values and other form values
  Future<void> updateValues() async {
    await firebaseFirestore
        .collection(fk_businessCollection)
        .doc(businessChooserStringValue)
        .get()
        .then((DocumentSnapshot value) {
      Map<String, dynamic> data = value.data();
      nameController.text = data[fk_businessName];
      reviewController.text = data[fk_textReview];
      uberEatsController.text = data[fk_uberEatsLink];
      rappiLinkController.text = data[fk_rappiLink];
      igLinkController.text = data[fk_igLink];
      phoneController.text = data[fk_phoneNumber];
      gordoTipController.text = listToString(data[fk_tipList]);
      favoriteDishesController.text = listToString(data[fk_bestPlateList]);
      moneyRating = data[fk_moneyRating];
      happyRating = data[fk_happyRating];
      houseRating = data[fk_houseRating];
      isActive = data[fk_isActive];
      mainImagePath = data[fk_businessMainImageAsset];
    });
  }

  /// Deals with uploading a list of Assets
  /// returns a list of paths from db
  Future uploadImages() async {
    print(images);
    String initalPath = nameController.text.replaceAll(" ", "");
    List<String> paths = List<String>();
    for (int i = 0; i < images.length; i++) {
      Asset asset = images[i];
      String path = await ImageGetter.uploadImage(
          asset: asset,
          isData: true,
          imagePath: 'businesses/$initalPath/${initalPath}_$i');
      paths.add(path);
    }
    return paths;
  }

  /// Deals with separating the string for every period
  List<String> getStringListByDot(String initial) {
    return initial.split('.');
  }

  /// Deals with updating the db
  Future<void> updateDB() async {
    String imagePath;
    String initalPath = nameController.text.replaceAll(" ", "");
    _mainImageFile != null
        ? imagePath = await ImageGetter.uploadImage(
            image: _mainImageFile,
            imagePath: 'businesses/$initalPath/${initalPath}_main')
        : null;

    List<String> paths;
    images.isNotEmpty ? paths = await uploadImages() : null;
    await firebaseFirestore
        .collection(fk_businessCollection)
        .doc(businessChooserStringValue)
        .update({
      fk_businessName: nameController.text,
      fk_happyRating: happyRating,
      fk_houseRating: houseRating,
      fk_moneyRating: moneyRating,
      fk_igLink: igLinkController.text,
      fk_businessMainImageAsset: imagePath ?? mainImagePath,
      fk_phoneNumber: phoneController.text,
      fk_rappiLink: rappiLinkController.text,
      fk_uberEatsLink: uberEatsController.text,
      fk_textReview: reviewController.text,
      fk_businessImageAssetList: FieldValue.arrayUnion(paths ?? []),
      fk_tipList: getStringListByDot(gordoTipController.text),
      fk_bestPlateList: getStringListByDot(favoriteDishesController.text),
      fk_isActive: isActive,
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    phoneController.dispose();
    favoriteDishesController.dispose();
    gordoTipController.dispose();
    igLinkController.dispose();
    rappiLinkController.dispose();
    uberEatsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    DropDownItemsGetter.getBusinesses(
        firebaseFirestore: firebaseFirestore,
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
        body: Container(
          padding: k_appPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleWidget(
                isImage: false,
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                mainText: 'Editar Negocio',
                textStyle: k_16wStyle,
              ),
              Text('Porfavor selecione un negocio a editar.'),
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
                  : SizedBox(), // TODO change to load asset
              businessChooserStringValue == null
                  ? SizedBox()
                  : Flexible(
                      fit: FlexFit.loose,
                      child: BusinessEditor(
                        finalOnTapFunction: () {
                          showDialog(
                            child: YesNoDialog(
                              dialogText:
                                  'Seguro que queires cambiar este negocio?',
                              onNoFunction: () => Navigator.pop(context),
                              onYesFunction: () async {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    child: CircularProgressIndicator());
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
                        finalButtonString: 'Cambiar Negocio',
                        isActiveFunction: (value) => setState(() {
                          isActive = value;
                        }),
                        isActive: isActive,
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
                        mainImageOnTapFunction: () async {
                          _mainImageFile = await ImageGetter.getImage().then(
                            (value) {
                              setState(() {});
                              return value;
                            },
                          );
                        },
                        isCategories: false,
                        moneyOnTapFunction: (value) => setState(() {
                          moneyRating = value;
                        }),
                        moneyRating: moneyRating,
                        houseOnTapFunction: (value) => setState(() {
                          houseRating = value;
                        }),
                        houseRating: houseRating,
                        happyRatingOnTapFunction: (value) => setState(() {
                          happyRating = value;
                        }),
                        happyRating: happyRating,
                        nameController: nameController,
                        favoriteDishesController: favoriteDishesController,
                        gordoTipController: gordoTipController,
                        igLinkController: igLinkController,
                        phoneController: phoneController,
                        rappiLinkController: rappiLinkController,
                        reviewController: reviewController,
                        uberEatsController: uberEatsController,
                        mainImagePath: _mainImageFile?.path ?? mainImagePath,
                        isOnlineMainImage: _mainImageFile == null,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
