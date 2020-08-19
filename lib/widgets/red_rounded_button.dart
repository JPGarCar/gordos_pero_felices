import 'package:flutter/material.dart';

import '../constants.dart';

class RedRoundedButton extends StatelessWidget {
  final Function onTapFunction;
  final String buttonText;

  RedRoundedButton({@required this.onTapFunction, this.buttonText = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        height: 35,
        padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: k_redColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: k_redColorLight,
              offset: Offset.fromDirection(.8, 8),
            ),
          ],
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: k_whiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
