import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/errors_names.dart';
import 'package:mynotes/screen/home_screen.dart';
import 'package:mynotes/screen/login_screen.dart';
import 'package:mynotes/screen/verify_email_screen.dart';
import 'package:mynotes/utilities/navigator.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class UserAccount {
  final BuildContext context;
  final String email;
  final String password;
  UserAccount({
    required this.context,
    required this.email,
    required this.password,
  });
  final _user = FirebaseAuth.instance;

  void logIn() async {
    try {
      await _user
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (_user.currentUser?.emailVerified ?? false) {
          namedRout(context, HomeScreen.routeName);
        } else {
          namedRout(context, VerifyEmailScreen.routeName);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorDialog(context, userNotFound);
      } else if (e.code == 'wrong-password') {
        showErrorDialog(context, wrongPassword);
      } else {
        showErrorDialog(context, unknownError);
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  void register() async {
    try {
      await _user
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _user.currentUser?.sendEmailVerification();
        namedRout(context, LoginScreen.routeName);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Register Success'),
              content: const Text(
                  'We send email verification Please log in after you verify your email'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showErrorDialog(context, emailAlreadyInUse);
      } else if (e.code == 'weak-password') {
        showErrorDialog(context, weakPassword);
      } else if (e.code == 'invalid-email') {
        showErrorDialog(context, invalidEmail);
      } else {
        showErrorDialog(context, 'Error :${e.code}');
      }
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }
}
