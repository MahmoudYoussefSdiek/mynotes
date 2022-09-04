import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtool show log;

import 'package:mynotes/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'enter your email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'enter your password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password)
                    .then((value) {
                  devtool.log('Register Complete');
                  namedRout(context, loginRoute);
                  //  Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
                });
                devtool.log(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'email-already-in-use') {
                  devtool.log('This email already in use');
                } else if (e.code == 'weak-password') {
                  devtool.log('weak password please enter another one');
                } else if (e.code == 'invalid-email') {
                  devtool.log('you enter invalid email');
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              namedRout(context, loginRoute);
              //  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: Text('Already registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
