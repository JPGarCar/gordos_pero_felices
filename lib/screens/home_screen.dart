import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/screens/menu_screen.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/custom/custom_bottom_sheet.dart'
    as cbs;
import 'package:gordos_pero_felizes/widgets/card/custom_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class HomeScreen extends StatefulWidget {
  static final String screenId = 'homeScreen';
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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

  List<CustomCard> cardList = [
    CustomCard(
      isOffline: true,
      name: 'Las Tres Bs',
      imageAssetPath: 'images/gourmet_burger.jpg',
    ),
    CustomCard(
      isOffline: true,
      name: 'Date Favorites',
      imageAssetPath: 'images/gourmet_burger.jpg',
    ),
    CustomCard(
      isOffline: true,
      name: 'Los Gordo Favoritos',
      imageAssetPath: 'images/gourmet_burger.jpg',
    ),
    CustomCard(
      isOffline: true,
      name: 'Los Más Buscados',
      imageAssetPath: 'images/gourmet_burger.jpg',
    ),
  ];

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
                    return cardList[index];
                  },
                  itemCount: cardList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
