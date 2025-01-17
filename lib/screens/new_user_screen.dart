import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'package:gordos_pero_felizes/models/enums/sex_enum.dart';
import 'package:gordos_pero_felizes/screens/home_screen.dart';
import 'package:gordos_pero_felizes/widgets/error_dialog.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

/// Uses Form validation to validate but we will use our own way of showing an error,
/// we will use a AlertDialog, not the regular way of doing things.
class NewUserScreen extends StatefulWidget {
  static final String screenId = 'newUserScreen';
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ScrollController scrollController = ScrollController();

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

  List<String> errors = [];

  /// Will try to register the user with email and password, if there are any
  /// errors it will return the error as a string, else will return a FirebaseUser
  Future<dynamic> singUpUser({String email, String password}) async {
    UserCredential authResult;
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
    scrollController.dispose();
    super.dispose();
  }

  /// used to scroll the scrollView all the way down
  void scrollDown() {
    var scrollPosition = scrollController.position;
    for (FocusNode focusNode in focusNodes) {
      if (focusNode.hasFocus && focusNodes.indexOf(focusNode) < 3) {
        scrollController.animateTo(
            scrollPosition.maxScrollExtent -
                (MediaQuery.of(context).size.height / 4),
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOut);
      } else if (focusNode.hasFocus && focusNodes.indexOf(focusNode) > 3) {
        scrollController.animateTo(scrollPosition.maxScrollExtent,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
        Flexible(
          fit: FlexFit.loose,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            hint: 'Nombre',
                            textEditingController: nameController,
                            isCapitalize: true,
                          ),
                        ),
                        Expanded(
                          child: RedRoundedTextField(
                            hint: 'Apellido',
                            textEditingController: lastNameController,
                            isCapitalize: true,
                          ),
                        ),
                      ],
                    ),
                    RedRoundedTextField(
                      hint: 'Correo Electrónico',
                      textEditingController: emailController,
                      isEmail: true,
                      validatorCallBack: (String value) {
                        if (!EmailValidator.validate(value.trim()))
                          errors.add(
                              'Porfavor escriba un correo electronico valido');
                        return null;
                      },
                    ),
                    RedRoundedTextField(
                      hint: 'Confirmar Correo',
                      textEditingController: confEmailController,
                      isEmail: true,
                      validatorCallBack: (String value) {
                        if (emailController.text.trim() != value.trim())
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
                        if (value.trim().length < 6)
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
                        if (passwordController.text.trim() != value.trim())
                          errors
                              .add('Asegurese que la contraseña sea correcta!');
                        return null;
                      },
                    ),
                    RedRoundedTextField(
                      focusNode: focusNodes[2],
                      hint: 'Ciudad',
                      textEditingController: cityController,
                      isCapitalize: true,
                    ),
                    RedRoundedDropDown(
                      hint: 'Genero',
                      value: _selectedGender,
                      onChangeFunction: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                        focusNodes[3].requestFocus();
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
                                  flex: 8,
                                  child: RedRoundedTextField(
                                    focusNode: focusNodes[3],
                                    hint: 'DD',
                                    isNumber: true,
                                    textEditingController: dayController,
                                    isCenterText: true,
                                    validatorCallBack: (String value) {
                                      if (!value.contains(
                                          new RegExp('^[1-3]*[0-9]\$')))
                                        errors.add(
                                            'Porfavor escriba un dia valido.');
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
                                    focusNode: focusNodes[4],
                                    hint: 'MM',
                                    isNumber: true,
                                    textEditingController: monthController,
                                    isCenterText: true,
                                    validatorCallBack: (String value) {
                                      if (!value.contains(
                                          new RegExp('^[1-9]\$|(^1[0-2]\$)')))
                                        errors.add(
                                            'Porfavor excriba un mes valido!');
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
                                Flexible(
                                  flex: 9,
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
                                        errors.add(
                                            'Porfavor escriba un año valido!');
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
          ),
        ),
      ],
    );
  }

  void submitButtonFunction() async {
    /// Validate form
    _formKey.currentState.validate();

    /// Check for any errors present
    if (errors.isEmpty) {
      /// try to register the user
      dynamic signUpResponse = await singUpUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

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
        /// Set provider User object data
        Provider.of<AppUser>(context, listen: false).setValues(
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
        Provider.of<AppUser>(context, listen: false).addUserToDB(_firestore);

        /// push on to home page
        Navigator.popAndPushNamed(context, HomeScreen.screenId);
      }
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
