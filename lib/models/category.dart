import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';

import '../firebase_constants.dart';

class Category {
  static Category getCategoryFromDocument(DocumentSnapshot documentSnapshot) {
    Map<dynamic, dynamic> mapData = documentSnapshot.data();
    var businesses = mapData[fk_businesses];

    List<Business> businessList = List<Business>();

    for (DocumentReference documentReference in businesses) {
      documentReference.get().then((DocumentSnapshot docSnapshot) {
        var value = docSnapshot.data();
        businessList.add(Business(
          businessName: value[fk_businessName],
          happyRating: value[fk_happyRating],
          houseRating: value[fk_houseRating],
          moneyRating: value[fk_moneyRating],
          mainImageAsset: value[fk_businessMainImageAsset],
          bestPlateList: List.from(value[fk_bestPlateList]),
          imageAssetList: List.from(value[fk_businessImageAssetList]),
          tipList: List.from(value[fk_tipList]),
          igLink: value[fk_igLink],
          phoneNumber: value[fk_phoneNumber],
          rappiLink: value[fk_rappiLink],
          textReview: value[fk_textReview],
          uberEatsLink: value[fk_uberEatsLink],
        ));
      });
    }

    return Category(
      name: mapData[fk_categoryName],
      imageAssetPath: mapData[fk_categoryImageAssetPath],
      businesses: businessList,
      isActive: mapData[fk_isActive],
    );
  }

  /// variables ///

  String name;
  String imageAssetPath;
  bool isActive;

  List<Business> businesses;

  /// Constructor

  Category(
      {@required this.name,
      @required this.imageAssetPath,
      this.businesses,
      this.isActive}) {
    businesses ??= [];
  }

  Category.empty() {
    name = "";
    imageAssetPath = "";
    businesses = [];
  }

  void copy(Category category) {
    name = category.name;
    imageAssetPath = category.imageAssetPath;
    businesses = category.businesses;
    isActive = category.isActive;
  }
}
