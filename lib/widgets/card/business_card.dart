import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/screens/business_screen.dart';
import '../../constants.dart';
import 'custom_card.dart';

class BusinessCard extends StatelessWidget {
  final Business business;
  final bool isOffline;

  BusinessCard({@required this.business, this.isOffline = false});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isOffline: isOffline,
      onTapFunction: () => Navigator.pushNamed(context, BusinessScreen.screenId,
          arguments: business),
      imageAssetPath: business.mainImageAsset,
      name: business.businessName,

      /// Sets the overlay of this CustomCard
      /// Overlay will be row with the icons, inside a black box with
      /// round borders in all sides except top left and bottom right
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
