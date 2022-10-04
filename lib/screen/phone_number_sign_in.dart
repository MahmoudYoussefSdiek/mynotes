import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes_name.dart';
import 'package:mynotes/screen/home_screen.dart';
import 'package:mynotes/utilities/navigator.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
import 'package:mynotes/widget/custom_button.dart';
import 'package:mynotes/widget/custom_textfield.dart';

class PhoneNumberSignIn extends StatefulWidget {
  const PhoneNumberSignIn({Key? key}) : super(key: key);
  static String routeName = phoneNumberRoute;

  @override
  State<PhoneNumberSignIn> createState() => _PhoneNumberSignInState();
}

class _PhoneNumberSignInState extends State<PhoneNumberSignIn> {
  late final TextEditingController _phoneController;
  late final TextEditingController _otpController;

  bool otpVisibility = false;
  String verificationID = '';

  @override
  void initState() {
    _phoneController = TextEditingController();
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Number SignIn'),
      ),
      body: Center(
        child: Column(children: [
          CustomTextField(
            controller: _phoneController,
            hintText: 'Enter your Phone number',
            textInputType: TextInputType.number,
          ),
          Visibility(
            visible: otpVisibility,
            child: CustomTextField(
                controller: _otpController,
                hintText: 'Enter SMS code',
                textInputType: TextInputType.number),
          ),
          CustomButton(
            onTap: () {
              if (otpVisibility) {
                verifyOTP(context, _otpController.text.trim());
              } else {
                phoneSignIn(context, _phoneController.text.trim());
              }
            },
            text: otpVisibility ? 'verify' : 'Sign In',
          ),
        ]),
      ),
    );
  }

  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          namedRout(context, HomeScreen.routeName);
        });
      },
      verificationFailed: (e) {
        showErrorDialog(context, e.code);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          otpVisibility = true;
          verificationID = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        showErrorDialog(context, 'Time out');
      },
    );
  }

  void verifyOTP(BuildContext context, String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: code,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      namedRout(context, HomeScreen.routeName);
    });
  }
}
