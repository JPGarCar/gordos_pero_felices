import 'package:flutter/cupertino.dart';
import 'package:gordos_pero_felizes/models/business.dart';

class Category {
  /// variables ///

  String name;
  String imageAssetPath;

  List<Business> businesses;

  /// Constructor

  Category(
      {@required this.name, @required this.imageAssetPath, this.businesses}) {
    businesses ??= [];
  }
}
