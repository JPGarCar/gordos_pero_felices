import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_button.dart';

class ErrorDialog extends StatelessWidget {
  final List<String> stringErrors;
  final Function cleanUp;

  ErrorDialog({this.stringErrors, this.cleanUp});

  List<Widget> getErrors() {
    List<Widget> errorList = [];
    for (String e in stringErrors) {
      errorList.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            e,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      );
    }
    return errorList;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Porfavor corriga los errores!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: getErrors(),
              ),
            ),
            RedRoundedButton(
              onTapFunction: () {
                Navigator.pop(context);
                cleanUp();
              },
              buttonText: 'Okay',
            ),
          ],
        ),
      ),
    );
  }
}