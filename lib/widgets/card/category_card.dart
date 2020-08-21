import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';
import 'custom_card.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isActive;

  CategoryCard({@required this.category, this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTapFunction: isActive
          ? () {
              Navigator.pushNamed(context, CategoryScreen.screenId);
            }
          : null,
      name: category.name,
      imageAssetPath: category.imageAssetPath,
    );
  }
}
