import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';

import '../constants.dart';

class BusinessCard extends StatelessWidget {
  final Business business;

  BusinessCard({@required this.business});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // TODO send to business page
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Container(
          height: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(k_circularBorderRadius),
            image: DecorationImage(
              image: AssetImage(business.mainImageAsset),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(k_circularBorderRadius),
                            bottomLeft:
                                Radius.circular(k_circularBorderRadius)),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Text(
                      business.businessName,
                      style: TextStyle(
                        color: k_whiteColor,
                        fontSize: 26,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
