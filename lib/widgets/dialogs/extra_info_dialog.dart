import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'file:///C:/Users/juapg/_Programming_Projects/AndroidStudioProjects/GordosPeroFelizes/gordos_pero_felizes/lib/models/enums/sex_enum.dart';
import 'package:gordos_pero_felizes/screens/home_screen.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../error_dialog.dart';

class ExtraInfoDialog extends StatefulWidget {
  @override
  _ExtraInfoDialogState createState() => _ExtraInfoDialogState();
}

class _ExtraInfoDialogState extends State<ExtraInfoDialog> {
  final cityController = TextEditingController();
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  Sex _selectedGender;

  List<String> errors = List<String>();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cityController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido!',
                  style: k_16wStyle,
                ),
                Text(
                  'Antes de seguir nesecitamos un poco más de informacion de ti.',
                  textAlign: TextAlign.center,
                ),
                RedRoundedTextField(
                  hint: 'Ciudad',
                  textEditingController: cityController,
                  isCapitalize: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Text(
                        'Fecha de Nacimiento',
                        style: TextStyle(
                          color: k_redColor,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: RedRoundedTextField(
                              hint: 'DD',
                              isNumber: true,
                              textEditingController: dayController,
                              isCenterText: true,
                              validatorCallBack: (String value) {
                                if (!value
                                    .contains(new RegExp('^[1-3]*[0-9]\$')))
                                  errors.add('Porfavor escriba un dia valido.');
                                return null;
                              },
                            ),
                          ),
                          Text(
                            '/',
                            style: TextStyle(
                              color: k_redColor,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: RedRoundedTextField(
                              hint: 'MM',
                              isNumber: true,
                              textEditingController: monthController,
                              isCenterText: true,
                              validatorCallBack: (String value) {
                                if (!value.contains(
                                    new RegExp('^[1-9]\$|(^1[0-2]\$)')))
                                  errors.add('Porfavor excriba un mes valido!');
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      RedRoundedTextField(
                        hint: 'YYYY',
                        isTextInputDone: true,
                        isNumber: true,
                        textEditingController: yearController,
                        isCenterText: true,
                        validatorCallBack: (String value) {
                          if (!value.contains(new RegExp('^[0-9]{4}\$')))
                            errors.add('Porfavor escriba un año valido!');
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                RedRoundedDropDown(
                  hint: 'Genero',
                  value: _selectedGender,
                  onChangeFunction: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  dropDownItems: [
                    DropdownMenuItem(
                      child: Text(getSexValue(Sex.male)),
                      value: Sex.male,
                    ),
                    DropdownMenuItem(
                      child: Text(getSexValue(Sex.female)),
                      value: Sex.female,
                    ),
                    DropdownMenuItem(
                      child: Text(getSexValue(Sex.other)),
                      value: Sex.other,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: RedRoundedButton(
                    onTapFunction: submitButtonFunction,
                    buttonText: 'Agregar Informacion',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitButtonFunction() async {
    /// Validate form
    _formKey.currentState.validate();

    /// Check for any errors present
    if (errors.isEmpty) {
      /// try to register the user
      Provider.of<AppUser>(context, listen: false).setValues(
        city: cityController.text,
        day: int.parse(dayController.text),
        month: int.parse(monthController.text),
        year: int.parse(yearController.text),
        sex: _selectedGender,
      );
      Provider.of<AppUser>(context, listen: false)
          .addUserToDB(FirebaseFirestore.instance);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, HomeScreen.screenId);
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ErrorDialog(
          extraFunction: () => errors.clear(),
          stringErrors: errors,
        ),
      );
    }
  }
}
