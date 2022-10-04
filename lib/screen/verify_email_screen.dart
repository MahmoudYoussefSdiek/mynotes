import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/navigator.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: <Widget>[
          const Text('Please verify your email address:'),
          TextButton(
            onPressed: () async {
              try {
                final user = FirebaseAuth.instance.currentUser!;
                await user.sendEmailVerification().then((_) {
                  namedRout(context, homeScreenRoute);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email verification sent'),
                    ),
                  );
                });
              } on FirebaseAuthException catch (e) {
                showErrorDialog(context, e.code);
              }
            },
            child: const Text('Send email verification'),
          ),
        ],
      ),
    );
  }
}