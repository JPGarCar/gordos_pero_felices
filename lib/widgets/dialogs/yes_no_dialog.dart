import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';

class YesNoDialog extends StatelessWidget {
  final Function onYesFunction;
  final Function onNoFunction;
  final String dialogText;

  YesNoDialog(
      {this.onNoFunction, this.onYesFunction, @required this.dialogText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dialogText,
              style: TextStyle(fontSize: 16),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RedRoundedButton(
                  buttonText: 'No',
                  onTapFunction: onNoFunction,
                ),
                RedRoundedButton(
                  buttonText: 'Si',
                  onTapFunction: onYesFunction,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
