import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/screens/home_screen.dart';
import 'package:gordos_pero_felizes/screens/new_user_screen.dart';
import 'package:gordos_pero_felizes/widgets/error_dialog.dart';
import 'file:///C:/Users/juapg/_Programming_Projects/AndroidStudioProjects/GordosPeroFelizes/gordos_pero_felizes/lib/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
import 'package:gordos_pero_felizes/widgets/custom_bottom_sheet.dart' as cbs;
import 'package:gordos_pero_felizes/widgets/simple_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  static final String screenId = 'initialScreen';

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/userinfo.profile',
    'https://www.googleapis.com/auth/userinfo.email	',
  ]);
  final _facebookLogin = FacebookLogin();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  List<String> errors = [];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Deals with the google login
  Future<bool> googleLogIn() async {
    print('Singing in with google ##########');
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser?.authentication;
      print('google done checking googleAuth: $googleAuth');
      if (googleAuth != null) {
        AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        UserCredential authResult =
            (await _auth.signInWithCredential(credential));
        User firebaseUser = authResult.user;

        /// Checking if this is the first time the user enters, if so create
        /// user in db
/*        if (authResult.additionalUserInfo.isNewUser){
          print(authResult.additionalUserInfo.profile);
        }*/

        print(authResult.additionalUserInfo.profile);

        print('signed in user ${firebaseUser.displayName}');
        if (firebaseUser != null) {
          // TODO check if first time logging in!
          AppUser.setUserFromDB(_firestore, firebaseUser.uid,
              Provider.of<AppUser>(context, listen: false));
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// Deals with the facebook login
  Future<bool> facebookLogIn() async {
    final result = await _facebookLogin.logInWithReadPermissions([
      'email',
      'instagram_basic',
      'user_birthday',
      'user_gender',
      'user_hometown',
    ]);

    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;

      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        /// calling the auth method and getting the logged user
        var credential =
            FacebookAuthProvider.credential(result.accessToken.token);
        var authResult = await _auth.signInWithCredential(credential);
        if (authResult != null) {
          // TODO check if first time logging in!
          AppUser.setUserFromDB(_firestore, authResult.user.uid,
              Provider.of<AppUser>(context, listen: false));
          return true;
        }
    }
    return false;
  }

  /// Deals with the email login
  Future<String> emailLogIn(String email, String password) async {
    var user = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((onError) {
      switch (onError.code) {
        case 'ERROR_WRONG_PASSWORD':
          return 'Tu contraseña es incorrecta!';
        case 'ERROR_USER_NOT_FOUND':
          return 'Este correo no esta en nuestro sistema, favor de crear una cuenta nueva.';
        default:
          return 'Se ha producido un error, favor de intentar de nuevo.';
      }
    });
    if (user != null) {
      /// update provider User object
      AppUser.setUserFromDB(_firestore, user.user.uid,
          Provider.of<AppUser>(context, listen: false));
      return null;
    } else {
      return 'Se ha producido un error, favor de intentar de nuevo.';
    }
  }

  /// email and password submit button function
  dynamic submitButtonFunction() async {
    {
      _key.currentState.validate();
      if (errors.isNotEmpty) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => ErrorDialog(
            stringErrors: errors,
            extraFunction: () => errors.clear(),
          ),
        );
      } else {
        String error =
            await emailLogIn(emailController.text, passwordController.text);
        if (error == null) {
          /// Navigate to home screen with the User object
          Navigator.popAndPushNamed(context, HomeScreen.screenId);
        } else {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              stringErrors: [error],
            ),
          );
        }
      }
    }
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
                child: Form(
                  key: _key,
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
                            validatorCallBack: (String value) {
                              if (!EmailValidator.validate(value)) {
                                errors.add(
                                    'Porfavor escriba un correo electronico valido.');
                                return null;
                              }
                            },
                          ),
                          RedRoundedTextField(
                            isTextInputDone: true,
                            hint: 'Contraseña',
                            isPassword: true,
                            textEditingController: passwordController,
                            validatorCallBack: (String value) {
                              if (value.length < 6) {
                                errors.add(
                                    'Porfavor escriba una contraseña valida.');
                                return null;
                              }
                            },
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
                          onTapFunction: submitButtonFunction,
                        ),
                      ),
                      Divider(
                        color: k_redColor,
                        thickness: 1.5,
                      ),
                      Column(
                        children: [
                          FacebookLogInButton(
                            onTapFunction: () async {
                              if (await facebookLogIn()) {
                                Navigator.popAndPushNamed(
                                    context, HomeScreen.screenId);
                              }
                            },
                          ),
                          GoogleLoginButton(
                            onTapFunction: () async {
                              if (await googleLogIn()) {
                                Navigator.popAndPushNamed(
                                    context, HomeScreen.screenId);
                              }
                            },
                          ),
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
                            backgroundColor: k_whiteColor,
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(k_circularBorderRadius),
                              ),
                            ),
                            builder: (context) {
                              return new NewUserScreen();
                            },
                          );
                        },
                      ),
                    ],
                  ),
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
  final Function onTapFunction;

  GoogleLoginButton({@required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Color.fromARGB(255, 66, 133, 244),
      highlightedBorderColor: Color.fromARGB(255, 66, 133, 244),
      color: Colors.white,
      onPressed: onTapFunction,
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
  final Function onTapFunction;

  FacebookLogInButton({@required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.white,
      highlightedBorderColor: Colors.blue,
      color: Colors.white,
      onPressed: onTapFunction,
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
