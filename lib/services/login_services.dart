import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gordos_pero_felizes/models/app_user.dart';
import 'package:provider/provider.dart';

class LoginServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Deals with the google login
  static Future<bool> googleLogIn(Function onSuccess) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      //'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email	',
    ]);

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
          onSuccess(firebaseUser.uid);
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// Deals with the facebook login
  static Future<bool> facebookLogIn(Function onSuccess) async {
    final _facebookLogin = FacebookLogin();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final result = await _facebookLogin.logInWithReadPermissions([
      'email',
      //'instagram_basic',
      //'user_birthday',
      //'user_gender',
      //'user_hometown',
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
          onSuccess(authResult.user.uid);
          return true;
        }
    }
    return false;
  }

  /// Deals with the email login
  static Future<String> emailLogIn(
      String email, String password, Function onSuccess) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

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
      /// call function passing user id
      onSuccess(user.user.uid);
      return null;
    } else {
      return 'Se ha producido un error, favor de intentar de nuevo.';
    }
  }
}
