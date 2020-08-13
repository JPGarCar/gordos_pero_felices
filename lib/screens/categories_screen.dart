import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/widgets/category_card.dart';

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
                'Restaurantes por Categoría',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 22,
                ),
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
                  itemCount: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
