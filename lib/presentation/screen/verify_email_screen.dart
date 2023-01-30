import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/presentation/components/constants/routes_name.dart';
import 'package:mynotes/presentation/components/widget/navigator.dart';
import 'package:mynotes/presentation/components/widget/show_error_dialog.dart';
import 'package:mynotes/presentation/screen/home_screen.dart';
import 'package:mynotes/presentation/screen/views/verify_email_body.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);
  static String routeName = verifyEmailRoute;
  //static final user = FirebaseAuth.instance.currentUser;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerification(context);
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  sendVerification(BuildContext context) async {
    final show = ScaffoldMessenger.of(context);
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification().then((_) {
        show.showSnackBar(
          const SnackBar(
            content: Text('Email verification sent'),
          ),
        );
      });
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 10));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      showErrorDialog(context, e.code);
    }
  }

  Widget showOutput(BuildContext context, bool isVerified, bool canResendEmail,
      String? userEmail) {
    if (isVerified) {
      return VerifyEmailBody(
        bodyText: 'Your email address verified',
        buttonText: 'Continue',
        onTap: () {
          namedRout(context, HomeScreen.routeName);
        },
      );
    } else {
      return VerifyEmailBody(
        bodyText: 'Please verify your email address: $userEmail',
        buttonText: 'Send email verification',
        onTap: () {
          canResendEmail
              ? sendVerification(context)
              : showErrorDialog(context,
                  'we send verification to your email pls confirm your email');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: showOutput(context, isEmailVerified, canResendEmail, user?.email),
    );
  }
}
