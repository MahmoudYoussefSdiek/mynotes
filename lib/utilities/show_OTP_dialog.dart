import 'package:flutter/material.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    // false = user must tap button, true = tap outside dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Enter SMS code'),
        content: TextField(
          controller: codeController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
