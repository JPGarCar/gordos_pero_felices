import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomCard extends StatelessWidget {
  final Function onTapFunction;
  final String imageAssetPath;
  final String name;
  final Widget overlay;
  final double height;
  final bool isColorFilter;

  CustomCard(
      {this.onTapFunction,
      this.imageAssetPath,
      this.name,
      this.overlay,
      this.height,
      this.isColorFilter = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Container(
          height: height ?? k_cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(k_circularBorderRadius),
            image: DecorationImage(
              image: AssetImage(imageAssetPath),
              fit: BoxFit.fill,
              colorFilter: isColorFilter
                  ? ColorFilter.mode(Colors.black54, BlendMode.darken)
                  : null,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              overlay ?? SizedBox(),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Text(
                      name ?? '',
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
