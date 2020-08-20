import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/screens/business_screen.dart';

import '../constants.dart';
import 'custom_card.dart';

class BusinessCard extends StatelessWidget {
  final Business business;

  BusinessCard({@required this.business});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTapFunction: () => Navigator.pushNamed(context, BusinessScreen.screenId,
          arguments: business), // TODO send to business page
      imageAssetPath: business.mainImageAsset,
      name: business.businessName,
      overlay: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(k_circularBorderRadius),
                    bottomLeft: Radius.circular(k_circularBorderRadius)),
                color: Colors.grey.shade900),
            height: 80,
            width: 115,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: business.grabMoneyIcons(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: business.grabHouseIcons(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: business.grabHappyIcons(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
