import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/user_screen.dart';
import 'package:gordos_pero_felizes/widgets/category_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

import '../constants.dart';

/// This screen holds all the available categories!
class CategoriesScreen extends StatefulWidget {
  static final String screenId = 'categoriesScreen';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
                mainText: 'Categorías',
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: Category(
                        name: 'Burgers',
                        imageAssetPath: 'images/gourmet_burger.jpg',
                      ),
                    );
                  },
                  itemCount: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
