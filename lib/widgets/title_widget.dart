import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/services/g_p_f_icons_icons.dart';

import '../constants.dart';

class TitleWidget extends StatefulWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final Function onPressedLeftIcon;
  final Function onPressedRightIcon;
  final String mainText;
  final bool isSearchBar;
  final TextStyle textStyle;
  final String secondaryText;
  final TextStyle secondaryTextStyle;
  final bool isImage;
  final bool isBusiness;
  final bool isFavorite;

  TitleWidget({
    this.leftIcon,
    this.onPressedLeftIcon,
    this.rightIcon,
    this.onPressedRightIcon,
    this.mainText = '',
    this.isSearchBar = false,
    this.textStyle,
    this.secondaryText,
    this.secondaryTextStyle,
    this.isImage = true,
    this.isBusiness = false,
    this.isFavorite = false,
  });

  TitleWidget.business({
    this.leftIcon = Icons.arrow_back,
    @required this.onPressedLeftIcon,
    this.rightIcon = Icons.account_circle,
    @required this.onPressedRightIcon,
    this.mainText = '',
    this.isSearchBar = false,
    this.textStyle,
    this.secondaryText,
    this.secondaryTextStyle,
    this.isImage = true,
    this.isBusiness = true,
    @required this.isFavorite,
  });

  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isBusiness
          // this is a special padding needed for the business page
          ? EdgeInsets.symmetric(
              vertical: k_appPaddingVertical,
              horizontal: k_appPaddingHorizontal)
          : EdgeInsets.only(bottom: k_appPaddingVertical),
      child: Column(
        children: [
          TopRow(
            leftIcon: widget.leftIcon,
            onPressedLeftIcon: widget.onPressedLeftIcon,
            rightIcon: widget.rightIcon,
            onPressedRightIcon: widget.onPressedRightIcon,
          ),
          widget.isImage
              ? Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Container(
                    height: 70,
                    child: Image.asset('images/gordos_logo.png'),
                  ),
                )
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 7,
                child: Text(
                  widget.mainText,
                  style: widget.textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              widget.isBusiness
                  ? Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: k_iconPadding),
                        child: Center(
                          child: IconButton(
                            color: k_redColor,
                            highlightColor: k_redColorLight,
                            splashColor: k_redColor,
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            icon: Icon(
                              isFavorite
                                  ? GPFIcons.heart
                                  : GPFIcons.heart_empty,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          widget.secondaryText != null
              ? Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.secondaryText,
                    style: widget.secondaryTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox(),
          widget.isSearchBar
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
