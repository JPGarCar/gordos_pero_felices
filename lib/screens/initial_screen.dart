import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/screens/new_user_screen.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/custom_bottom_sheet.dart' as cbs;

class InitialScreen extends StatefulWidget {
  static final String screenId = 'initialScreen';

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: k_appPadding,
          color: k_whiteColor,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 15),
                        child: Image.asset(
                          'images/gordos_logo.png',
                        ),
                      ),
                      fit: FlexFit.loose,
                      flex: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RedRoundedTextField(
                          isEmail: true,
                          hint: 'Correo Electrónico',
                          textEditingController: emailController,
                        ),
                        RedRoundedTextField(
                          hint: 'Contraseña',
                          isPassword: true,
                          textEditingController: passwordController,
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO send users to get new password
                          },
                          child: Text(
                            'olvidaste tu contraseña?',
                            style: TextStyle(
                              color: k_redColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 2,
                      child: RedRoundedButton(
                        buttonText: 'Ingresar',
                        onTapFunction: () {
                          cbs.showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return SingleChildScrollView(
                                    child: NewUserScreen());
                              });
                        },
                      ),
                    ),
                    Divider(
                      color: k_redColor,
                      thickness: 1.5,
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      color: Colors.lightBlueAccent,
                      child: Text('Facebook'),
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      color: Colors.grey,
                      child: Text('google'),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO send users to get new password
                      },
                      child: Text(
                        'Crear una cuenta aquí',
                        style: TextStyle(
                          color: k_redColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
