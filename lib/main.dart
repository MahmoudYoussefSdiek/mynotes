import 'package:flutter/material.dart';
import 'package:mynotes/presentation/screen/home_screen.dart';
import 'package:mynotes/presentation/screen/login_screen.dart';
import 'package:mynotes/presentation/screen/phone_number_sign_in.dart';
import 'package:mynotes/presentation/screen/register_screen.dart';
import 'package:mynotes/presentation/screen/sign_in_screen.dart';
import 'package:mynotes/presentation/screen/verify_email_screen.dart';
import 'package:mynotes/presentation/screen/views/main_route_page.dart';

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
