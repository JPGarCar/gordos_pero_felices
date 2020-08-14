import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/screens/new_user_screen.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/custom_bottom_sheet.dart' as cbs;
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';

class InitialScreen extends StatefulWidget {
  static final String screenId = 'initialScreen';

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                        padding: EdgeInsets.only(top: 30, bottom: 15),
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
                        SimpleTextButton(
                          verticalPadding: 0,
                          text: 'olvidaste tu contraseña?',
                          textStyle: TextStyle(
                            color: k_redColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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
                          // TODO
                        },
                      ),
                    ),
                    Divider(
                      color: k_redColor,
                      thickness: 1.5,
                    ),
                    Column(
                      children: [
                        FacebookLogInButton(),
                        GoogleLoginButton(),
                      ],
                    ),
                    SimpleTextButton(
                      verticalPadding: 0,
                      text: 'Crear una cuenta aquí',
                      textStyle: TextStyle(
                        color: k_redColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      onTapCallBack: () {
                        cbs.showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(k_circularBorderRadius),
                              ),
                            ),
                            builder: (context) {
                              return SingleChildScrollView(
                                  controller: scrollController,
                                  child: new NewUserScreen(
                                    scrollController: scrollController,
                                  ));
                            });
                      },
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

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Color.fromARGB(255, 66, 133, 244),
      highlightedBorderColor: Color.fromARGB(255, 66, 133, 244),
      color: Colors.white,
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(k_circularBorderRadius),
      ),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Image.asset(
                'images/google_logo.png',
                height: 18.0,
              ),
            ),
            Text(
              'Ingresa con Google',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FacebookLogInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.white,
      highlightedBorderColor: Colors.blue,
      color: Colors.white,
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(k_circularBorderRadius),
      ),
      highlightElevation: 0,
      borderSide: BorderSide(color: Color.fromARGB(255, 66, 103, 178)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 24),
              child: Image.asset(
                'images/facebook_logo.png',
                height: 18,
              ),
            ),
            Text(
              'Ingresa con Facebook',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 66, 103, 178),
                  fontFamily: 'Klavika'),
            )
          ],
        ),
      ),
    );
  }
}
