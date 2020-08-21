import 'package:flutter/material.dart';

import '../../constants.dart';

class RedRoundedButton extends StatefulWidget {
  final Function onTapFunction;
  final String buttonText;

  RedRoundedButton({@required this.onTapFunction, this.buttonText = ''});

  @override
  _RedRoundedButtonState createState() => _RedRoundedButtonState();
}

class _RedRoundedButtonState extends State<RedRoundedButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isSelected = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isSelected = false;
        });
      },
      onTap: () {
        setState(() {
          isSelected = true;
        });
        widget.onTapFunction();
      },
      child: AnimatedContainer(
        onEnd: () {
          setState(() {
            isSelected = false;
          });
        },
        duration: Duration(milliseconds: 350),
        height: 35,
        padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: k_redColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: k_redColorLight,
              offset: Offset.fromDirection(.8, isSelected ? 0 : 8),
            ),
          ],
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            color: k_whiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
