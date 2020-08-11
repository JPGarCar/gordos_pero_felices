import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
          color: k_whiteColor,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Image.asset(
                        'images/gordos_logo.png',
                      ),
                      fit: FlexFit.loose,
                      flex: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RedRoundedTextField(
                          isEmail: true,
                          hint: 'Nombre de Usuario',
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
                        )
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          // TODO send user to new user screen
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: k_redColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: k_redColorLight,
                                offset: Offset.fromDirection(.8, 10),
                              ),
                            ],
                          ),
                          child: Text(
                            'Nuevos Usuarios',
                            style: TextStyle(
                              color: k_whiteColor,
                              fontSize: 18,
                            ),
                          ),
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

class RedRoundedTextField extends StatelessWidget {
  final bool isEmail;
  final bool isPassword;
  final String hint;
  final TextEditingController textEditingController;

  RedRoundedTextField(
      {this.isEmail = false,
      this.isPassword = false,
      @required this.hint,
      @required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: k_redColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: k_redColorLight,
              offset: Offset.fromDirection(.8, 10),
            ),
          ],
        ),
        child: TextField(
          controller: textEditingController,
          style: TextStyle(
            color: k_whiteColor,
            fontSize: 16,
          ),
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: k_whiteColor,
              fontSize: 14,
            ),
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
