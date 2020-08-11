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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: k_redColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: k_redColorLight,
              offset: Offset.fromDirection(.8, 10),
            ),
          ],
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: k_whiteColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
