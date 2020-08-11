import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';

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
      this.igLink = ''}) {
    tipList ??= [];
    bestPlateList ??= [];
    imageAssetList ??= [];
  }

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
}
