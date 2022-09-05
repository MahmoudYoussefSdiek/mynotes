import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String massge) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('An error occurred'),
        content: Text(massge),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
