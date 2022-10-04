import 'package:flutter/material.dart';
import 'package:mynotes/widget/custom_button.dart';

class VerifyEmailBody extends StatelessWidget {
  const VerifyEmailBody({
    Key? key,
    required this.bodyText,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);
  final String bodyText;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(bodyText),
          CustomButton(onTap: onTap, text: buttonText),
        ],
      ),
    );
  }
}
