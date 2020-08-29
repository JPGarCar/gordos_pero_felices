import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_constants.dart';

class Category {
  /// Return a Category object with the data from the given documentSnapshot
  static Category getCategoryFromDocument(DocumentSnapshot documentSnapshot) {
    Map<dynamic, dynamic> mapData = documentSnapshot.data();
    List<dynamic> list = mapData[fk_businesses];
    List<DocumentReference> documentReferences = list.cast();

    return Category(
      name: mapData[fk_categoryName],
      imageAssetPath: mapData[fk_categoryImageAssetPath],
      businessReferences: documentReferences,
      isActive: mapData[fk_isActive],
    );
  }

  /// variables ///

  String name;
  String imageAssetPath;
  bool isActive;

  List<DocumentReference> businessReferences;

  /// Constructor

  Category(
      {@required this.name,
      @required this.imageAssetPath,
      this.businessReferences,
      this.isActive}) {
    businessReferences ??= [];
  }

  Category.empty() {
    name = "";
    imageAssetPath = "";
    businessReferences = [];
  }

  void copy(Category category) {
    name = category.name;
    imageAssetPath = category.imageAssetPath;
    businessReferences = category.businessReferences;
    isActive = category.isActive;
  }
}
