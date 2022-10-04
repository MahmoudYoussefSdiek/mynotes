import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes_name.dart';
import 'package:mynotes/screen/home_screen.dart';
import 'package:mynotes/screen/login_screen.dart';
import 'package:mynotes/screen/phone_number_sign_in.dart';
import 'package:mynotes/screen/register_screen.dart';
import 'package:mynotes/utilities/navigator.dart';
import 'package:mynotes/services/firebase/google_facebook.dart';
import 'package:mynotes/widget/custom_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routeName = signInScreenRoute;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your sign in pattern'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                onTap: () {
                  pushNamedRout(context, LoginScreen.routeName);
                },
                text: 'Email/password Login'),
            CustomButton(
                onTap: () {
                  pushNamedRout(context, RegisterScreen.routeName);
                },
                text: 'Email/password Register'),
            CustomButton(
                onTap: () {
                  googleSignIn(context);
                },
                text: 'Google SignIn'),
            CustomButton(
                onTap: () {
                  facebookSignIn(context);
                },
                text: 'Facebook SignIn'),
            CustomButton(
                onTap: () {
                  pushNamedRout(context, PhoneNumberSignIn.routeName);
                },
                text: 'Phone Number SignIn'),
            //  CustomButton(onTap: () {}, text: 'Anonymous SignIn'),
          ],
        ),
      ),
    );
  }
}

googleSignIn(BuildContext context) async {
  await AuthService().signInWithGoogle(context).then((value) {
    namedRout(context, HomeScreen.routeName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('welcome'),
      ),
    );
  });
}

facebookSignIn(BuildContext context) async {
  await AuthService().signInWithFacebook(context).then((value) {
    namedRout(context, HomeScreen.routeName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Welcome'),
      ),
    );
  });
}
