import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../constants.dart';

List<String> errors = [];

/// Uses Form validation to validate but we will use our own way of showing an error,
/// we will use a AlertDialog, not the regular way of doing things.
class NewUserScreen extends StatefulWidget {
  static final String screenId = 'newUserScreen';
  final ScrollController scrollController;
  NewUserScreen({this.scrollController});

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final confEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();
  final cityController = TextEditingController();
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  double pixelTo = 0;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    confEmailController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    cityController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    super.dispose();
  }

  void scrollDown() {
    for (FocusNode focusNode in focusNodes) {
      if (focusNode.hasFocus) {
        var scrollPosition = this.widget.scrollController.position;
        this.widget.scrollController.animateTo(scrollPosition.maxScrollExtent,
            duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    for (FocusNode focusNode in focusNodes) {
      focusNode.addListener(scrollDown);
    }
    KeyboardVisibilityNotification().addNewListener(
      onShow: () {
        Future.delayed(Duration(milliseconds: 10), () => scrollDown());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SimpleTextButton(
                onTapCallBack: () {
                  Navigator.pop(context);
                },
                text: 'Regresar',
                textStyle: TextStyle(
                  color: k_redColor,
                  fontWeight: FontWeight.w700,
                ),
                verticalPadding: 0,
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  child: Container(
                    height: 90,
                    child: Image.asset(
                      'images/gordos_logo.png',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: RedRoundedTextField(
                          hint: 'Nombre',
                          textEditingController: nameController),
                    ),
                    Expanded(
                      child: RedRoundedTextField(
                          hint: 'Apellido',
                          textEditingController: lastNameController),
                    ),
                  ],
                ),
                RedRoundedTextField(
                  hint: 'Correo Electrónico',
                  textEditingController: emailController,
                  isEmail: true,
                  validatorCallBack: (String value) {
                    if (!EmailValidator.validate(value))
                      errors
                          .add('Porfavor escriba un correo electronico valido');
                    return null;
                  },
                ),
                RedRoundedTextField(
                  hint: 'Confirmar Correo',
                  textEditingController: confEmailController,
                  isEmail: true,
                  validatorCallBack: (String value) {
                    if (emailController.text != value)
                      errors.add(
                          'Asegurese que su correo electronico sea correcto.');
                    return null;
                  },
                ),
                RedRoundedTextField(
                  focusNode: focusNodes[0],
                  hint: 'Contraseña',
                  textEditingController: passwordController,
                  isPassword: true,
                  validatorCallBack: (String value) {
                    if (value.length < 6)
                      errors.add(
                          'Porfavor escriba una contraseña de más de 6 characteres.');
                    return null;
                  },
                ),
                RedRoundedTextField(
                  focusNode: focusNodes[1],
                  hint: 'Confirmar Contraseña',
                  textEditingController: confPasswordController,
                  isPassword: true,
                  validatorCallBack: (String value) {
                    if (passwordController.text != value)
                      errors.add('Asegurese que la contraseña sea correcta!');
                    return null;
                  },
                ),
                RedRoundedTextField(
                  focusNode: focusNodes[2],
                  hint: 'Ciudad',
                  textEditingController: cityController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Text(
                        'Fecha de Nacimiento',
                        style: TextStyle(
                          color: k_redColor,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: RedRoundedTextField(
                                focusNode: focusNodes[3],
                                hint: 'DD',
                                isNumber: true,
                                textEditingController: dayController,
                                isCenterText: true,
                                validatorCallBack: (String value) {
                                  if (!value
                                      .contains(new RegExp('^[1-3]*[0-9]\$')))
                                    errors
                                        .add('Porfavor escriba un dia valido.');
                                  return null;
                                },
                              ),
                            ),
                            Text(
                              '/',
                              style: TextStyle(
                                color: k_redColor,
                                fontSize: 40,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: RedRoundedTextField(
                                focusNode: focusNodes[4],
                                hint: 'MM',
                                isNumber: true,
                                textEditingController: monthController,
                                isCenterText: true,
                                validatorCallBack: (String value) {
                                  if (!value.contains(
                                      new RegExp('^[1-9]\$|(^1[0-2]\$)')))
                                    errors
                                        .add('Porfavor excriba un mes valido!');
                                  return null;
                                },
                              ),
                            ),
                            Text(
                              '/',
                              style: TextStyle(
                                color: k_redColor,
                                fontSize: 40,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: RedRoundedTextField(
                                focusNode: focusNodes[5],
                                hint: 'YYYY',
                                isTextInputDone: true,
                                isNumber: true,
                                textEditingController: yearController,
                                isCenterText: true,
                                validatorCallBack: (String value) {
                                  if (!value
                                      .contains(new RegExp('^[0-9]{4}\$')))
                                    errors
                                        .add('Porfavor escriba un año valido!');
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RedRoundedButton(
                    onTapFunction: () {
                      _formKey.currentState.validate();
                      if (errors.isEmpty) {
                        // TODO
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return ErrorDialog(
                              stringErrors: errors,
                            );
                          },
                        );
                      }
                    },
                    buttonText: 'Crear Usuario',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final List<String> stringErrors;

  ErrorDialog({this.stringErrors});

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
                errors.clear();
              },
              buttonText: 'Okay',
            ),
          ],
        ),
      ),
    );
  }
}
