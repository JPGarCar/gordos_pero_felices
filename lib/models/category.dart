import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';

class Category {
  static Category getCategoryFromDocument(DocumentSnapshot documentSnapshot) {
    Map<dynamic, dynamic> mapData = documentSnapshot.data();
    print(mapData);
    var businesses = mapData['businesses'];

    List<Business> businessList = List<Business>();

    for (DocumentReference documentReference in businesses) {
      documentReference.get().then((DocumentSnapshot docSnapshot) {
        var value = docSnapshot.data();
        businessList.add(Business(
          businessName: value['businessName'],
          happyRating: value['happyRating'],
          houseRating: value['houseRating'],
          moneyRating: value['moneyRating'],
          mainImageAsset: value['mainImageAsset'],
          bestPlateList: List.from(value['bestPlateList']),
          imageAssetList: List.from(value['imageAssetList']),
          tipList: List.from(value['tipList']),
          igLink: value['igLink'],
          phoneNumber: value['phoneNumber'],
          rappiLink: value['rappiLink'],
          textReview: value['textReview'],
          uberEatsLink: value['uberEatsLink'],
        ));
      });
    }

    return Category(
      name: mapData['name'],
      imageAssetPath: mapData['imageAssetPath'],
      businesses: businessList,
    );
  }

  /// variables ///

  String name;
  String imageAssetPath;

  List<Business> businesses;

  /// Constructor

  Category(
      {@required this.name, @required this.imageAssetPath, this.businesses}) {
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
  }
}
