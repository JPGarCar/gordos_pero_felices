import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/widgets/category_card.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

import '../constants.dart';

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
                leftIcon: Icons.list,
                rightIcon: Icons.account_circle,
                mainText: 'Categorias',
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
