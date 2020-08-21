import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'file:///C:/Users/juapg/_Programming_Projects/AndroidStudioProjects/GordosPeroFelizes/gordos_pero_felizes/lib/widgets/card/business_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

import '../constants.dart';

/// This screen holds all the businesses in one category!
class CategoryScreen extends StatefulWidget {
  static final String screenId = 'categoryScreen';
  @override
  State<StatefulWidget> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Widget> getIconList(IconData iconData, int amount) {
    List<Widget> moneyList = new List();
    for (var i = 0; i < amount; i++) {
      moneyList.add(Icon(
        iconData,
        color: Colors.red,
      ));
    }
    return moneyList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: k_whiteColor,
        body: Container(
          padding: k_appPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleWidget(
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                rightIcon: Icons.account_circle,
                onPressedRightIcon: () =>
                    Navigator.pushNamed(context, UserScreen.screenId),
                mainText: 'Restauratnes Americandos',
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return BusinessCard(
                      business: Business(
                          businessName: 'Ryoshi',
                          bestPlateList: [
                            'El bowl',
                            'La carne',
                            'El desayuno',
                          ],
                          tipList: [
                            'Pideo mucho chile',
                            'Toma mucha agua',
                          ],
                          happyRating: 3,
                          houseRating: 2,
                          moneyRating: 4,
                          textReview: 'This is a great business',
                          mainImageAsset: 'images/gourmet_burger.jpg'),
                    );
                  },
                  itemCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
