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
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'dart:io';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:gordos_pero_felizes/models/business.dart';

class NewBusinessScreen extends StatefulWidget {
  static final screenId = 'newBusinessScreen';

  @override
  _NewBusinessScreenState createState() => _NewBusinessScreenState();
}

class _NewBusinessScreenState extends State<NewBusinessScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  bool isActive = true;
  int happyRating;
  int houseRating;
  int moneyRating;
  File _mainImage;

  String categoryDropDownValue;
  List<DropdownMenuItem> categoryDropDownItems;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController favoriteDishesController = TextEditingController();
  TextEditingController gordoTipController = TextEditingController();
  TextEditingController igLinkController = TextEditingController();
  TextEditingController rappiLinkController = TextEditingController();
  TextEditingController uberEatsController = TextEditingController();

  List<Asset> images = List<Asset>();

  /// Deals with creating the Business object and uploading files to storage
  Future addBusiness() async {
    String initalPath = nameController.text.replaceAll(" ", "");
    String mainImagePath = await ImageGetter.uploadImage(
        image: _mainImage,
        imagePath: 'businesses/$initalPath/${initalPath}_main');
    List<String> paths = await AdminServices.uploadImages(
      images: images,
      businessName: nameController.text.replaceAll(" ", ""),
    );

    Business business = new Business(
      businessName: nameController.text,
      moneyRating: moneyRating,
      houseRating: houseRating,
      happyRating: happyRating,
      textReview: reviewController.text,
      mainImageAsset: mainImagePath,
      imageAssetList: paths,
      tipList: AdminServices.getStringListByDot(gordoTipController.text),
      bestPlateList:
          AdminServices.getStringListByDot(favoriteDishesController.text),
      rappiLink: rappiLinkController.text,
      uberEatsLink: uberEatsController.text,
      phoneNumber: phoneController.text,
      igLink: igLinkController.text,
      isActive: isActive,
    );

    await business.addBusinessToDB(firebaseFirestore);
    await firebaseFirestore
        .collection(fk_categoryCollection)
        .doc(categoryDropDownValue)
        .update({
      fk_businesses: FieldValue.arrayUnion([
        firebaseFirestore
            .collection(fk_businessCollection)
            .doc(business.businessName)
      ]),
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
    DropDownItemsGetter.getCategories(
      finalThenFunction: (dropDownItems) => setState(() {
        categoryDropDownItems = dropDownItems;
      }),
      firebaseFirestore: firebaseFirestore,
    );
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
                mainText: 'Agregar un Negocio Nuevo',
                textStyle: k_16wStyle,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: BusinessEditor(
                  finalOnTapFunction: () {
                    showDialog(
                      child: YesNoDialog(
                        dialogText: 'Seguro que queires agregar este negocio?',
                        onNoFunction: () => Navigator.pop(context),
                        onYesFunction: () async {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              child: CircularProgressIndicator());
                          addBusiness().whenComplete(
                            () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                child: ConfirmDialog(
                                  text:
                                      'El negocio se ha agregado correctamente!',
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
                  finalButtonString: 'Agregar Negocio',
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
                    _mainImage = await ImageGetter.getImage().then(
                      (value) {
                        setState(() {});
                        return value;
                      },
                    );
                  },
                  categoryOnChangeFunction: (value) => setState(() {
                    categoryDropDownValue = value;
                  }),
                  categoryDropDownItems: categoryDropDownItems,
                  categoryDropDownValue: categoryDropDownValue,
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
                  mainImagePath: _mainImage?.path,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
