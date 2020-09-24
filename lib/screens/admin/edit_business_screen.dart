import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
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
      gordoTipController.text = AdminServices.listToString(data[fk_tipList]);
      favoriteDishesController.text =
          AdminServices.listToString(data[fk_bestPlateList]);
      moneyRating = data[fk_moneyRating];
      happyRating = data[fk_happyRating];
      houseRating = data[fk_houseRating];
      isActive = data[fk_isActive];
      mainImagePath = data[fk_businessMainImageAsset];
    });
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
    images.isNotEmpty
        ? paths = await AdminServices.uploadImages(
            images: images,
            businessName: nameController.text.replaceAll(" ", ""))
        : null;
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
      fk_tipList: AdminServices.getStringListByDot(gordoTipController.text),
      fk_bestPlateList:
          AdminServices.getStringListByDot(favoriteDishesController.text),
      fk_isActive: isActive,
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                                    context: context, child: LoadingGif());
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
