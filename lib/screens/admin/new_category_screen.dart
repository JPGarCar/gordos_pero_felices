import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/services/image_getter.dart';
import 'package:gordos_pero_felizes/widgets/card/category_card.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/confirm_dialog.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
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

  /// Deals with uploading category info to firestore
  Future uploadCategory(String name) async {
    String assetPath = await ImageGetter.uploadImage(
        image: _image, imagePath: 'categories/$name');
    _firestore.collection(fk_categoryCollection).doc(name).set({
      fk_categoryImageAssetPath: assetPath,
      fk_categoryName: name,
      fk_businesses: List<DocumentReference>(),
      fk_isActive: isActive,
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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
              RedRoundedSwitch(
                text: 'Activo?',
                value: isActive,
                onChangeFunction: (value) {
                  setState(() {
                    isActive = value;
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
                                text: 'La categoría se agregó correctamente!',
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
    );
  }
}
