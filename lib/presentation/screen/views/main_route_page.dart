import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/presentation/screen/home_screen.dart';
import 'package:mynotes/presentation/screen/sign_in_screen.dart';
import 'package:mynotes/presentation/screen/verify_email_screen.dart';

class MainRoutPage extends StatelessWidget {
  const MainRoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              switch (user.providerData[0].providerId) {
                case 'password':
                  if (user.emailVerified) {
                    return const HomeScreen();
                  } else {
                    return const VerifyEmailScreen();
                  }
                case 'google.com':
                  return const HomeScreen();

                case 'facebook.com':
                  return const HomeScreen();

                case 'phone':
                  return const HomeScreen();
              }
            } else {
              return const SignInScreen();
            }
            return const SignInScreen();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
