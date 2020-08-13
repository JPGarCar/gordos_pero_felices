import 'package:flutter/cupertino.dart';

import '../constants.dart';

class SimpleTextButton extends StatelessWidget {
  final String text;
  final Function onTapCallBack;
  final TextStyle textStyle;

  SimpleTextButton(
      {@required this.text,
      this.onTapCallBack,
      this.textStyle = k_defaultTextButtonStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: onTapCallBack,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
