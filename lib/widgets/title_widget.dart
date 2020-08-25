import 'package:flutter/material.dart';

import '../constants.dart';

class TitleWidget extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final Function onPressedLeftIcon;
  final Function onPressedRightIcon;
  final String mainText;
  final bool isSearchBar;
  final TextStyle textStyle;
  final bool isSecondaryText;
  final String secondaryText;
  final TextStyle secondaryTextStyle;
  final bool isImage;

  TitleWidget({
    this.leftIcon,
    this.onPressedLeftIcon,
    this.rightIcon,
    this.onPressedRightIcon,
    this.mainText = '',
    this.isSearchBar = false,
    this.textStyle,
    this.isSecondaryText = false,
    this.secondaryText,
    this.secondaryTextStyle,
    this.isImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          TopRow(
            leftIcon: leftIcon,
            onPressedLeftIcon: onPressedLeftIcon,
            rightIcon: rightIcon,
            onPressedRightIcon: onPressedRightIcon,
          ),
          isImage
              ? Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Container(
                    height: 70,
                    child: Image.asset('images/gordos_logo.png'),
                  ),
                )
              : SizedBox(),
          Text(
            mainText,
            style: textStyle,
          ),
          isSecondaryText
              ? Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    secondaryText,
                    style: secondaryTextStyle,
                  ),
                )
              : SizedBox(),
          isSearchBar
              ? Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: SearchBar(),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class TopRow extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final Function onPressedLeftIcon;
  final Function onPressedRightIcon;

  TopRow(
      {this.leftIcon,
      this.onPressedLeftIcon,
      this.rightIcon,
      this.onPressedRightIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onPressedLeftIcon,
          child: Icon(
            leftIcon,
            color: k_redColor,
            size: k_iconSize,
          ),
        ),
        GestureDetector(
          onTap: onPressedRightIcon,
          child: Icon(
            rightIcon,
            color: k_redColor,
            size: k_iconSize,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: k_redColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        style: TextStyle(
          color: k_whiteColor,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: k_whiteColor,
          ),
          hintStyle: TextStyle(
            color: k_whiteColor,
            fontSize: 16,
          ),
          hintText: 'Busca restaurantes...',
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
