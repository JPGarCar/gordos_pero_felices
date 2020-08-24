import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomPopupMenuButton extends StatelessWidget {
  CustomPopupMenuButton({@required this.iconData});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(0, 100),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(iconData),
              Text("-"),
              Icon(iconData),
              Icon(iconData),
              Icon(iconData),
            ],
          ),
        ),
        PopupMenuItem(child: Icon(iconData)),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(iconData),
              Icon(iconData),
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: <Widget>[
              Icon(iconData),
              Icon(iconData),
              Icon(iconData),
            ],
          ),
        )
      ],
      icon: Icon(iconData),
    );
  }
}
