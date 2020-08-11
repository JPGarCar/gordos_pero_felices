import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';

class RedRoundedTextField extends StatelessWidget {
  final bool isEmail;
  final bool isPassword;
  final String hint;
  final bool isCenterText;
  final TextEditingController textEditingController;

  RedRoundedTextField(
      {this.isEmail = false,
      this.isPassword = false,
      this.isCenterText = false,
      @required this.hint,
      @required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        //constraints: BoxConstraints.tightFor(height: 35), TODO check if they want to change this
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
        child: TextField(
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          controller: textEditingController,
          style: TextStyle(
            color: k_whiteColor,
            fontSize: 16,
          ),
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: k_whiteColor,
              fontSize: 14,
            ),
            hintText: hint,
            contentPadding: EdgeInsets.only(right: 10, left: 10),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
