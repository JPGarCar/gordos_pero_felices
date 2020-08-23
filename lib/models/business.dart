import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';

/// This is the Business class, it represents a business from the real world.
/// It holds all the business info, from images to ratings, to google map stuff.

class Business {
  /// variables ///

  int moneyRating;
  int houseRating;
  int happyRating;

  String businessName;
  String textReview;
  List<String> tipList;
  List<String> bestPlateList;

  // TODO menu
  List<String> imageAssetList;
  String mainImageAsset;
  String rappiLink;
  String uberEatsLink;
  String phoneNumber;
  String igLink;
  // TODO google maps data

  bool isActive;

  /// Constructor ///
  /// ratings and textReview are required, everything else can be added later,
  /// lists will be initialized if not given in constructor.
  Business(
      {@required this.businessName,
      @required this.moneyRating,
      @required this.houseRating,
      @required this.happyRating,
      @required this.textReview,
      this.mainImageAsset = '',
      this.imageAssetList,
      this.tipList,
      this.bestPlateList,
      this.rappiLink = '',
      this.uberEatsLink = '',
      this.phoneNumber = '',
      this.igLink = '',
      this.isActive = true}) {
    tipList ??= List<String>();
    bestPlateList ??= List<String>();
    imageAssetList ??= List<String>();
  }

  /// Will return x amount of given iconsData as a list.
  List<Widget> grabIcons(int amount, IconData iconData) {
    List<Widget> iconList = [];
    for (int i = 0; i < amount; i++) {
      iconList.add(Icon(
        iconData,
        color: k_whiteColor,
        size: k_cardIconSize,
      ));
    }
    return iconList;
  }

  List<Widget> grabMoneyIcons() {
    return grabIcons(moneyRating, Icons.attach_money);
  }

  List<Widget> grabHouseIcons() {
    return grabIcons(houseRating, Icons.home);
  }

  List<Widget> grabHappyIcons() {
    return grabIcons(happyRating, Icons.tag_faces);
  }

  /// add this business to db
  /// requires: a firestore instance to add to db
  /// assumes collection is named 'users'
  Future<void> addBusinessToDB(FirebaseFirestore firestore) {
    return firestore.collection(fk_businessCollection).doc(businessName).set({
      fk_businessName: businessName,
      fk_happyRating: happyRating,
      fk_houseRating: houseRating,
      fk_moneyRating: moneyRating,
      fk_igLink: igLink,
      fk_businessMainImageAsset: mainImageAsset,
      fk_phoneNumber: phoneNumber,
      fk_rappiLink: rappiLink,
      fk_uberEatsLink: uberEatsLink,
      fk_textReview: textReview,
      fk_businessImageAssetList: imageAssetList,
      fk_tipList: tipList,
      fk_bestPlateList: bestPlateList,
      fk_isActive: isActive,
    });
  }
}
