import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes_name.dart';
import 'package:mynotes/screen/login_screen.dart';
import 'package:mynotes/services/firebase/email_pasword.dart';
import 'package:mynotes/utilities/navigator.dart';
import 'package:mynotes/widget/custom_button.dart';
import 'package:mynotes/widget/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String routeName = registerRoute;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
            CustomTextField(
                controller: _email,
                hintText: 'enter your email',
                textInputType: TextInputType.emailAddress),
            CustomTextField(
                controller: _password,
                hintText: 'enter your password',
                textInputType: TextInputType.visiblePassword),
            CustomButton(
                onTap: () {
                  UserAccount(
                          context: context,
                          email: _email.text.trim(),
                          password: _password.text.trim())
                      .register();
                },
                text: 'Register'),
            TextButton(
              onPressed: () {
                namedRout(context, LoginScreen.routeName);
              },
              child: const Text('Already registered? Login here!'),
            ),
          ],
        ),
      ),
    );
  }
}
