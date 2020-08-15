import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/widgets/business_card.dart';

import '../constants.dart';

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
        bottomSheet: BottomSheet(
            onClosing: () {},
            builder: (context) {
              return SizedBox(
                height: 20,
              );
            }
            // TODO to be determined,
            ),
        body: Container(
          padding: k_appPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.list,
                    color: k_redColor,
                    size: k_iconSize,
                  ),
                  Icon(
                    Icons.account_circle,
                    color: k_redColor,
                    size: k_iconSize,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Container(
                  height: 80,
                  child: Image.asset('images/gordos_logo.png'),
                ),
              ),
              Text(
                'Restaurantes Americanos',
                style: TextStyle(
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
                          businessName: 'Frat Pack',
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
