import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/menu_screen.dart';
import 'package:gordos_pero_felizes/widgets/business_card.dart';
import 'package:gordos_pero_felizes/widgets/category_card.dart';
import 'package:gordos_pero_felizes/widgets/custom_bottom_sheet.dart' as cbs;
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class HomeScreen extends StatefulWidget {
  static final String screenId = 'homeScreen';
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
                isSearchBar: true,
                mainText: 'Restaurante para cualquiér ocasión',
                rightIcon: Icons.account_circle,
                leftIcon: Icons.list,
                onPressedLeftIcon: () {
                  return cbs.showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(k_circularBorderRadius),
                        topRight: Radius.circular(k_circularBorderRadius),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return MenuScreen();
                    },
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: Category(
                        name: 'Burgers',
                        imageAssetPath: 'images/gourmet_burger.jpg',
                      ),
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
