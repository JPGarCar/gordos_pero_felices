import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/services/dropdown_items_getter.dart';
import 'package:gordos_pero_felizes/services/image_getter.dart';
import 'package:gordos_pero_felizes/widgets/card/category_card.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/confirm_dialog.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_switch.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class NewCategoryScreen extends StatefulWidget {
  static final screenId = 'newCategoryScreen';

  @override
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File _image;
  TextEditingController nameController = TextEditingController();
  bool isActive = true;

  /// var to know if new category is for home screen!
  bool isSpecial = false;

  /// List of businesses to add to category
  List<String> businessIDs = List<String>();

  /// Drop down items and query of all businesses
  List<DropdownMenuItem> dropDownItems;
  String businessID;
  QuerySnapshot querySnapshot;

  /// Deals with uploading category info to firestore
  Future uploadCategory(String name) async {
    // Get document references of businesses choosen
    List<DocumentReference> list = List<DocumentReference>();

    querySnapshot.docs
        .where((element) => businessIDs.contains(element.id))
        .forEach((element) {
      list.add(element.reference);
    });

    String assetPath = await ImageGetter.uploadImage(
        image: _image, imagePath: 'categories/$name');
    _firestore
        .collection(
            isSpecial ? fk_specialCategoryCollection : fk_categoryCollection)
        .doc(name)
        .set({
      fk_categoryImageAssetPath: assetPath,
      fk_categoryName: name,
      fk_businesses: list,
      fk_isActive: isActive,
    });
  }

  /// Will get all the possible businesses for the drop down
  void getBusinesses() {
    DropDownItemsGetter.getBusinesses(
        firebaseFirestore: _firestore,
        thenFinalFunction: (items, value) {
          querySnapshot = value;
          setState(() {
            dropDownItems = items;
          });
        });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getBusinesses();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: k_appPadding,
          child: Column(
            children: [
              TitleWidget(
                isImage: false,
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                mainText: 'Agregar una Categoría Nueva',
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RedRoundedTextField(
                        onChangedFunction: (string) {
                          setState(() {});
                        },
                        isTextInputDone: true,
                        hint: 'Nombre de categoría',
                        textEditingController: nameController,
                      ),
                      RedRoundedButton(
                        buttonText: 'Escojer imagen de categoria',
                        onTapFunction: () async {
                          _image = await ImageGetter.getImage();
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          children: [
                            Text(
                              'Preview de la categoría:',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            _image != null
                                ? CategoryCard(
                                    isOffline: true,
                                    isActive: false,
                                    category: new Category(
                                      name: nameController.text,
                                      imageAssetPath: _image.path,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      dropDownItems != null
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RedRoundedDropDown(
                                    dropDownItems: dropDownItems,
                                    value: businessID,
                                    hint: 'Negocio a agregar',
                                    onChangeFunction: (value) {
                                      setState(() {
                                        businessIDs.add(value);
                                        dropDownItems.removeWhere((element) =>
                                            element.value == value);
                                      });
                                    },
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: businessIDs.length,
                                      itemBuilder: (context, index) {
                                        return BusinessListItem(
                                          businessID: businessIDs[index],
                                          onTapFunction: () {
                                            setState(() {
                                              dropDownItems.add(
                                                DropdownMenuItem(
                                                  value: businessIDs[index],
                                                  child:
                                                      Text(businessIDs[index]),
                                                ),
                                              );
                                              businessIDs.removeAt(index);
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      RedRoundedSwitch(
                        text: 'Activo?',
                        value: isActive,
                        onChangeFunction: (value) {
                          setState(() {
                            isActive = value;
                          });
                        },
                      ),
                      RedRoundedSwitch(
                        text: 'Especial?',
                        value: isSpecial,
                        onChangeFunction: (value) {
                          setState(() {
                            isSpecial = value;
                          });
                        },
                      ),
                      _image != null
                          ? nameController.text != ""
                              ? RedRoundedButton(
                                  buttonText: 'Agregar Categoría Nueva',
                                  onTapFunction: () async {
                                    await uploadCategory(nameController.text);
                                    showDialog(
                                      context: context,
                                      child: ConfirmDialog(
                                        text:
                                            'La categoría se agregó correctamente!',
                                        onTapFunction: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                )
                              : SizedBox()
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessListItem extends StatelessWidget {
  final String businessID;
  final Function onTapFunction;

  BusinessListItem({this.businessID, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            businessID,
            style: k_16wStyle,
          ),
          GestureDetector(
            child: Icon(Icons.remove_circle),
            onTap: onTapFunction,
          ),
        ],
      ),
    );
  }
}
