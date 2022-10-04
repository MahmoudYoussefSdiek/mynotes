import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/handle_error.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/navigator.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
import 'package:mynotes/utilities/sign_in_metod.dart';

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
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    namedRout(context, loginRoute);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Register Success'),
                          content:
                              const Text('Please log in now with your email'),
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
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () {
                signInWithGoogle(context);
              },
              child: const Text('SignIn with Google account'),
            ),
            TextButton(
              onPressed: () {
                namedRout(context, loginRoute);
              },
              child: const Text('Already registered? Login here!'),
            ),
          ],
        ),
      ),
    );
  }
}
