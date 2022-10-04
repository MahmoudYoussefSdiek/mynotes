import 'package:flutter/material.dart';
import 'package:mynotes/screen/home_screen.dart';
import 'package:mynotes/screen/login_screen.dart';
import 'package:mynotes/screen/phone_number_sign_in.dart';
import 'package:mynotes/screen/register_screen.dart';
import 'package:mynotes/screen/sign_in_screen.dart';
import 'package:mynotes/screen/verify_email_screen.dart';
import 'package:mynotes/views/main_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainRoutPage(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
        PhoneNumberSignIn.routeName: (context) => const PhoneNumberSignIn(),
        SignInScreen.routeName: (context) => const SignInScreen(),
      },
    );
  }
}
