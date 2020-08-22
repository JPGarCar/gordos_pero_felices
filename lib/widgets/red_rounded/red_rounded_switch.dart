import 'package:flutter/material.dart';

import '../../constants.dart';

class RedRoundedSwitch extends StatelessWidget {
  final bool value;
  final Function onChangeFunction;
  final String text;

  RedRoundedSwitch({this.value, this.onChangeFunction, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 35,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: k_redColor,
          borderRadius: BorderRadius.circular(k_circularBorderRadius),
          boxShadow: [
            BoxShadow(
              color: k_redColorLight,
              offset: Offset.fromDirection(.8, 8),
            ),
          ],
        ),
        child: Center(
          widthFactor: 1.2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: k_whiteColor),
              ),
              Switch.adaptive(
                activeTrackColor: k_redColorLight,
                activeColor: k_whiteColor,
                inactiveThumbColor: Colors.grey,
                value: value,
                onChanged: onChangeFunction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
