import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/models/category.dart';

import '../constants.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({@required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // TODO send to category page
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Container(
          height: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(k_circularBorderRadius),
            image: DecorationImage(
              image: AssetImage(category.imageAssetPath),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Text(
                      category.name,
                      style: TextStyle(
                        color: k_whiteColor,
                        fontSize: 26,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
