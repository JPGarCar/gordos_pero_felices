import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';

class RedRoundedTextField extends StatelessWidget {
  final bool isEmail;
  final bool isPassword;
  final bool isNumber;
  final String hint;
  final bool isCenterText;
  final TextEditingController textEditingController;
  final Function validatorCallBack;
  final bool isTextInputDone;
  final FocusNode focusNode;
  final Function onTapFunciton;
  final bool isCapitalize;
  final Function onChangedFunction;

  RedRoundedTextField({
    this.isEmail = false,
    this.isPassword = false,
    this.isCenterText = false,
    this.isNumber = false,
    this.isTextInputDone = false,
    this.isCapitalize = false,
    this.onTapFunciton,
    this.focusNode,
    this.validatorCallBack,
    @required this.hint,
    @required this.textEditingController,
    this.onChangedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 35,
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
        child: TextFormField(
          onChanged: onChangedFunction ?? null,
          textCapitalization:
              isCapitalize ? TextCapitalization.words : TextCapitalization.none,
          onTap: onTapFunciton,
          focusNode: focusNode,
          textInputAction:
              isTextInputDone ? TextInputAction.done : TextInputAction.next,
          onFieldSubmitted: isTextInputDone
              ? (_) => FocusScope.of(context).unfocus()
              : (_) => FocusScope.of(context).nextFocus(),
          validator: validatorCallBack,
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          controller: textEditingController,
          style: TextStyle(
            color: k_whiteColor,
            fontSize: 16,
          ),
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : isNumber ? TextInputType.number : TextInputType.text,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: k_whiteColor,
              fontSize: 14,
            ),
            hintText: hint,
            contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: 15),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
