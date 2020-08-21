import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as pt;
import 'dart:io';

class ImageGetter {
  final picker = ImagePicker();
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// Deals with getting images from the phone!
  static Future<File> getImage() async {
    var picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  /// Deals with uploading the image to firebase storage
  static Future<String> uploadImage(
      {File image,
      Asset asset,
      String initialPath = 'categories/',
      isData = false}) async {
    FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference = isData
        ? _firebaseStorage.ref().child('$initialPath${asset.name}')
        : _firebaseStorage
            .ref()
            .child('$initialPath${pt.basename(image.path)}');
    StorageUploadTask uploadTask = isData
        ? storageReference
            .putData((await asset.getByteData()).buffer.asUint8List())
        : storageReference.putFile(image);
    await uploadTask.onComplete;
    return uploadTask.lastSnapshot.storageMetadata.path;
  }
}
