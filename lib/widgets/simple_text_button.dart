import 'package:flutter/cupertino.dart';

import '../constants.dart';

class SimpleTextButton extends StatelessWidget {
  final String text;
  final Function onTapCallBack;
  final TextStyle textStyle;
  final double verticalPadding;

  SimpleTextButton(
      {@required this.text,
      this.onTapCallBack,
      this.textStyle = k_defaultTextButtonStyle,
      this.verticalPadding = 17.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
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
