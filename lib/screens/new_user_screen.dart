import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/user.dart';
import 'package:gordos_pero_felizes/screens/home_screen.dart';
import 'package:gordos_pero_felizes/widgets/error_dialog.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:gordos_pero_felizes/models/sex_enum.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../constants.dart';

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
  final _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  var _selectedGender;

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

  List<String> errors = [];

  /// Will try to register the user with email and password, if there are any
  /// errors it will return the error as a string, else will return a FirebaseUser
  Future<dynamic> singUpUser({String email, String password}) async {
    AuthResult authResult;
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      var errorCode = e.code;
      if (errorCode == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return 'Este correo electronico ya esta registrado.';
      } else {
        return 'Se ha producido un error, porfavor intente de nuevo.';
      }
    }
    return authResult.user;
  }

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

  /// used to scroll the scrollView all the way down
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

    /// for loop and KeyBoard... will move scrollView down once we reach the
    /// middle textField or click on any of the textFields bellow the middle
    /// textField.
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
    return StickyHeader(
      header: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(k_circularBorderRadius)),
          color: k_whiteColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        constraints: BoxConstraints.expand(height: 40),
        child: SimpleTextButton(
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
      ),
      content: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
        color: k_whiteColor,
        child: Form(
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
                        hint: 'Nombre', textEditingController: nameController),
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
                    errors.add('Porfavor escriba un correo electronico valido');
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
              RedRoundedDropDown(
                hint: 'Genero',
                value: _selectedGender,
                onChangeFunction: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
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
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: RedRoundedTextField(
                              focusNode: focusNodes[3],
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
                              fontSize: 40,
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: RedRoundedTextField(
                              focusNode: focusNodes[4],
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
                          Text(
                            '/',
                            style: TextStyle(
                              color: k_redColor,
                              fontSize: 40,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: RedRoundedTextField(
                              focusNode: focusNodes[5],
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: RedRoundedButton(
                  onTapFunction: submitButtonFunction,
                  buttonText: 'Crear Usuario',
                ),
              ),
            ],
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
      dynamic signUpResponse = await singUpUser(
          email: emailController.text, password: passwordController.text);

      if (signUpResponse.runtimeType == String) {
        /// show dialog with the error
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ErrorDialog(
            stringErrors: [signUpResponse],
          ),
        );
      } else {
        /// if no return error then create user object
        User user = new User(
          uid: signUpResponse.uid,
          name: nameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          city: cityController.text,
          day: int.parse(dayController.text),
          month: int.parse(monthController.text),
          year: int.parse(yearController.text),
          sex: _selectedGender,
        );

        /// add user object to db
        user.addUserToDB(_firestore);

        /// push on to home page
        Navigator.popAndPushNamed(context, HomeScreen.screenId);
      }
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ErrorDialog(
          cleanUp: () => errors.clear(),
          stringErrors: errors,
        ),
      );
    }
  }
}
