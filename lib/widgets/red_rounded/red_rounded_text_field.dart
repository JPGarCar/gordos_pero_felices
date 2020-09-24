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
  final bool isMultiLine;
  final String initialValue;

  RedRoundedTextField({
    this.isMultiLine = false,
    this.isEmail = false,
    this.isPassword = false,
    this.isCenterText = false,
    this.isNumber = false,
    this.isTextInputDone = false,
    this.isCapitalize = false,
    this.onTapFunciton,
    this.focusNode,
    this.validatorCallBack,
    this.hint = '',
    this.textEditingController,
    this.onChangedFunction,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: isMultiLine ? 150 : 35,
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
          initialValue: initialValue,
          maxLines: isMultiLine ? 10 : 1,
          onChanged: onChangedFunction ?? null,
          textCapitalization: isCapitalize
              ? TextCapitalization.words
              : isEmail
                  ? TextCapitalization.none
                  : isPassword
                      ? TextCapitalization.none
                      : TextCapitalization.sentences,
          onTap: onTapFunciton,
          focusNode: focusNode,
          textInputAction:
              isTextInputDone ? TextInputAction.done : TextInputAction.next,
          onFieldSubmitted: isTextInputDone
              ? (value) => FocusScope.of(context).unfocus()
              : (value) => FocusScope.of(context).nextFocus(),
          validator: validatorCallBack,
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          controller: textEditingController,
          style: TextStyle(
            color: k_whiteColor,
            fontSize: 16,
          ),
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : isNumber
                  ? TextInputType.number
                  : isMultiLine ? TextInputType.multiline : TextInputType.text,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: k_whiteColor,
              fontSize: 14,
            ),
            hintText: hint,
            contentPadding: isMultiLine
                ? EdgeInsets.symmetric(vertical: 15, horizontal: 20)
                : EdgeInsets.only(right: 20, left: 20, bottom: 15),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
