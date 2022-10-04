import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes_name.dart';
import 'package:mynotes/screen/register_screen.dart';
import 'package:mynotes/services/firebase/email_pasword.dart';
import 'package:mynotes/utilities/navigator.dart';
import 'package:mynotes/widget/custom_button.dart';
import 'package:mynotes/widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = loginRoute;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: _email,
            hintText: 'enter your email',
            textInputType: TextInputType.emailAddress,
          ),
          CustomTextField(
            controller: _password,
            hintText: 'enter your password',
            textInputType: TextInputType.visiblePassword,
          ),
          CustomButton(
              onTap: () {
                UserAccount(
                        context: context,
                        email: _email.text.trim(),
                        password: _password.text.trim())
                    .logIn();
              },
              text: 'Login'),
          CustomButton(
              onTap: () {
                namedRout(context, RegisterScreen.routeName);
              },
              text: 'Not registered yet ? Register here!')
        ],
      ),
    );
  }
}
