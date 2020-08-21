import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io';

class ImageGetter {
  final picker = ImagePicker();
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// Deals with getting images from the phone!
  static Future<File> getImage() async {
    var picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 420, imageQuality: 70);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  /// Deals with uploading the image to firebase storage
  static Future<dynamic> uploadImage(
      {File image,
      Asset asset,
      @required String imagePath,
      isData = false}) async {
    FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference = isData
        ? _firebaseStorage.ref().child(imagePath)
        : _firebaseStorage.ref().child(imagePath);
    StorageUploadTask uploadTask = isData
        ? storageReference.putData(
            (await asset.getByteData(quality: 70)).buffer.asUint8List())
        : storageReference.putFile(image);
    await uploadTask.onComplete.catchError((onError) {
      print(onError);
      return "";
    });
    return storageReference.getDownloadURL().catchError((onError) {
      print('there has been an error!');
      return "";
    });
  }
}
