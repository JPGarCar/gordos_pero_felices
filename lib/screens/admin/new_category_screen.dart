import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/widgets/card/category_card.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as pt;

class NewCategoryScreen extends StatefulWidget {
  static final screenId = 'newCategoryScreen';

  @override
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  File _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  /// Deals with getting images from the phone!
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  /// Deals with uploading category info to firestore
  Future uploadCategory(String name) async {
    String assetPath = await uploadImage();
    _firestore.collection('categories').add({
      'imageAssetPath': assetPath,
      'name': name,
    });
  }

  /// Deals with uploading the image to firebase storage
  Future<String> uploadImage() async {
    print('called function!');
    StorageReference storageReference =
        _firebaseStorage.ref().child('categories/${pt.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    print('right before await!');
    await uploadTask.onComplete;
    print('photo is up!');
    print(uploadTask.lastSnapshot.storageMetadata.path);
    return uploadTask.lastSnapshot.storageMetadata.path;
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
                onTapFunction: getImage,
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
              _image != null
                  ? nameController.text != ""
                      ? RedRoundedButton(
                          buttonText: 'Agregar Categoría Nueva',
                          onTapFunction: () =>
                              uploadCategory(nameController.text),
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
