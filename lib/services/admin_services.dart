import 'package:multi_image_picker/multi_image_picker.dart';

import 'image_getter.dart';

/// A few functions that are shared across the admin screens!
class AdminServices {
  /// Deals with separating the string for every period
  static List<String> getStringListByDot(String initial) {
    return initial.split('.');
  }

  /// Deals with creating a single string separated by . from a list of strings
  static String listToString(List<dynamic> list) {
    String compoundedText = '';
    for (String string in list) {
      compoundedText = compoundedText + string + '. ';
    }
    return compoundedText;
  }

  /// Deals with uploading a list of Assets
  /// returns a list of paths from db
  static Future uploadImages({List<Asset> images, String businessName}) async {
    String initalPath = businessName;
    List<String> paths = List<String>();
    for (int i = 0; i < images.length; i++) {
      Asset asset = images[i];
      String path = await ImageGetter.uploadImage(
        asset: asset,
        isData: true,
        imagePath: 'businesses/$initalPath/${initalPath}_$i',
      );
      paths.add(path);
    }
    return paths;
  }
}
