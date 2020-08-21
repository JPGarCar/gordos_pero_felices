import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/services/image_getter.dart';
import 'package:gordos_pero_felizes/widgets/card/custom_card.dart';
import 'package:gordos_pero_felizes/widgets/error_dialog.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
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

  int happyRating;
  int houseRating;
  int moneyRating;
  File _mainImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController favoriteDishesController = TextEditingController();
  TextEditingController gordoTipController = TextEditingController();
  TextEditingController igLinkController = TextEditingController();
  TextEditingController rappiLinkController = TextEditingController();
  TextEditingController uberEatsController = TextEditingController();

  List<Asset> images = List<Asset>();

  /// Returns a list of DropDownItems with values 1 to 5
  List<DropdownMenuItem> getOneToFive() {
    List<DropdownMenuItem> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add(
        DropdownMenuItem(
          child: Text('$i'),
          value: i,
        ),
      );
    }
    return list;
  }

  /// Deals with multi image picker
  Future<void> loadAssets() async {
    images = List<Asset>();

    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(maxImages: 10);
    } catch (e) {
      print(e);
    }

    images = resultList;
  }

  /// Deals with separating the string for every period
  List<String> getStringListByDot(String initial) {
    return initial.split('.');
  }

  /// Deals with uploading a list of Assets
  /// returns a list of paths from db
  Future uploadImages() async {
    String initalPath = nameController.text.replaceAll(" ", "");
    List<String> paths = List<String>();
    for (Asset asset in images) {
      String path = await ImageGetter.uploadImage(
          asset: asset, isData: true, initialPath: 'businesses/$initalPath/');
      paths.add(path);
    }
    return paths;
  }

  /// Deals with creating the Business object and uploading files to storage
  Future addBusiness() async {
    String initalPath = nameController.text.replaceAll(" ", "");
    String mainImagePath = await ImageGetter.uploadImage(
        image: _mainImage, initialPath: 'businesses/$initalPath/');
    List<String> paths = await uploadImages();

    Business business = new Business(
      businessName: nameController.text,
      moneyRating: moneyRating,
      houseRating: houseRating,
      happyRating: happyRating,
      textReview: reviewController.text,
      mainImageAsset: mainImagePath,
      imageAssetList: paths,
      tipList: getStringListByDot(gordoTipController.text),
      bestPlateList: getStringListByDot(favoriteDishesController.text),
      rappiLink: rappiLinkController.text,
      uberEatsLink: uberEatsController.text,
      phoneNumber: phoneController.text,
      igLink: igLinkController.text,
    );

    business.addBusinessToDB(firebaseFirestore);
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
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RedRoundedTextField(
                        hint: 'Nombre de Negocio',
                        textEditingController: nameController,
                      ),
                      RedRoundedTextField(
                        isMultiLine: true,
                        hint: 'Review de negocio...',
                        textEditingController: reviewController,
                      ),
                      RedRoundedDropDown(
                        iconData: Icons.tag_faces,
                        hint: 'Rating Comida',
                        value: happyRating,
                        onChangeFunction: (value) {
                          setState(() {
                            happyRating = value;
                          });
                        },
                        dropDownItems: getOneToFive(),
                      ),
                      RedRoundedDropDown(
                        iconData: Icons.home,
                        hint: 'Rating Lugar',
                        value: houseRating,
                        onChangeFunction: (value) {
                          setState(() {
                            houseRating = value;
                          });
                        },
                        dropDownItems: getOneToFive(),
                      ),
                      RedRoundedDropDown(
                        iconData: Icons.attach_money,
                        hint: 'Rating Dinero',
                        value: moneyRating,
                        onChangeFunction: (value) {
                          setState(() {
                            moneyRating = value;
                          });
                        },
                        dropDownItems: getOneToFive(),
                      ),
                      RedRoundedButton(
                        buttonText: 'Escojer Imagen Principal',
                        onTapFunction: () async {
                          _mainImage = await ImageGetter.getImage();
                          setState(() {});
                        },
                      ),
                      _mainImage != null
                          ? Column(
                              children: [
                                Text('Preview...'),
                                CustomCard(
                                    imageAssetPath: _mainImage.path,
                                    name: nameController.text // TODO,
                                    ),
                              ],
                            )
                          : SizedBox(),
                      RedRoundedButton(
                        buttonText: 'Escojer imagenes secundarias',
                        onTapFunction: () {
                          loadAssets();
                          return GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(images.length, (index) {
                              Asset asset = images[index];
                              return AssetThumb(
                                asset: asset,
                                width: 250,
                                height: 250,
                              );
                            }),
                          );
                        },
                      ),
                      RedRoundedTextField(
                        isNumber: true,
                        hint: 'Telefono',
                        textEditingController: phoneController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                                'Cada renglon, separado por un . es un platillo.'),
                            RedRoundedTextField(
                              isMultiLine: true,
                              hint: 'Platillos favoritos...',
                              textEditingController: favoriteDishesController,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text('Cada renglon, separado por un . es un tip.'),
                            RedRoundedTextField(
                              isMultiLine: true,
                              hint: 'Gordo Tips...',
                              textEditingController: gordoTipController,
                            ),
                          ],
                        ),
                      ),
                      RedRoundedTextField(
                        hint: 'Instagram Link',
                        textEditingController: igLinkController,
                      ),
                      RedRoundedTextField(
                        hint: 'Rappi Link',
                        textEditingController: rappiLinkController,
                      ),
                      RedRoundedTextField(
                        hint: 'Uber Eats Link',
                        textEditingController: uberEatsController,
                        isTextInputDone: true,
                      ),
                      RedRoundedButton(
                        buttonText: 'Agregar Negocio',
                        onTapFunction: () {
                          showDialog(
                            child: Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Seguro que queires agregar este negocio?',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RedRoundedButton(
                                          buttonText: 'No',
                                          onTapFunction: () =>
                                              Navigator.pop(context),
                                        ),
                                        RedRoundedButton(
                                          buttonText: 'Si',
                                          onTapFunction: () async {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                child:
                                                    CircularProgressIndicator());
                                            addBusiness().whenComplete(
                                              () {
                                                Navigator.pop(context);
                                                showDialog(
                                                  context: context,
                                                  child: Dialog(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                              'El negocio se ha agregado correctamente!'),
                                                          RedRoundedButton(
                                                            buttonText: 'Okay',
                                                            onTapFunction: () {
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            context: context,
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
