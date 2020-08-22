import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';
import 'package:provider/provider.dart';
import 'custom_card.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isActive;
  final bool isOffline;

  CategoryCard(
      {@required this.category, this.isActive = true, this.isOffline = false});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      isOffline: isOffline,
      onTapFunction: isActive
          ? () {
              Provider.of<Category>(context, listen: false).copy(category);
              Navigator.pushNamed(context, CategoryScreen.screenId);
            }
          : null,
      name: category.name,
      imageAssetPath: category.imageAssetPath,
    );
  }
}
