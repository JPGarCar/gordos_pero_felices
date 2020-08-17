import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/menu_screen.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
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

/// will show the custom modal bottom sheet
dynamic showCustomModalBottomSheet(BuildContext context) {
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
      });
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
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16,
                ),
                isSearchBar: true,
                mainText: 'Restaurante para cualquiér ocasión',
                rightIcon: Icons.account_circle,
                onPressedRightIcon: () =>
                    Navigator.pushNamed(context, UserScreen.screenId),
                leftIcon: Icons.list,
                onPressedLeftIcon: () => showCustomModalBottomSheet(context),
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
