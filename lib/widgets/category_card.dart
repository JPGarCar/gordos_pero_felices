import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';

import '../constants.dart';
import 'custom_card.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({@required this.category});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTapFunction: () {
        Navigator.pushNamed(context, CategoryScreen.screenId);
      },
      name: category.name,
      imageAssetPath: category.imageAssetPath,
    );
  }
}
