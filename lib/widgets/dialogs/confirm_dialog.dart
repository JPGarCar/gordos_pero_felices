import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';

class ConfirmDialog extends StatelessWidget {
  final Function onTapFunction;

  ConfirmDialog({this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('El negocio se ha agregado correctamente!'),
            RedRoundedButton(
              buttonText: 'Okay',
              onTapFunction: onTapFunction,
            )
          ],
        ),
      ),
    );
  }
}
