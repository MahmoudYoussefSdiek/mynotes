import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtool show log;

import 'package:mynotes/constants/routes.dart';

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
              final user = FirebaseAuth.instance.currentUser;
              devtool.log(user?.email.toString() ?? 'null');
              // if (user != null) {
              //   devtool.log(user.email.toString());
              // } else {
              //   devtool.log('null');
              // }

              await user?.sendEmailVerification().then((_) {
                devtool.log('done');
                namedRout(context, homeScreenRoute);
                //  Navigator.pushNamedAndRemoveUntil(context, homeScreenRoute, (route) => false);
              });
            },
            child: const Text('Send email verification'),
          ),
        ],
      ),
    );
  }
}
