import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/category.dart';
import 'package:gordos_pero_felizes/screens/category_screen.dart';
import 'package:provider/provider.dart';
import 'custom_card.dart';

/// A category card is the 'profile picture' of the category, these are presented
/// in the categories_screen.dart screen.
/// Created from a CustomCard with a specific onTapFunction
/// Requires: A category
/// Params: isActive-> enable/disble onTapFunction
///         isOffline-> CustomCard required
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
              /// Updates the Category Provider to the one of this Card for
              /// use in category_screen.dart
              Provider.of<Category>(context, listen: false).copy(category);
              Navigator.pushNamed(context, CategoryScreen.screenId);
            }
          : null,
      name: category.name,
      imageAssetPath: category.imageAssetPath,
    );
  }
}
