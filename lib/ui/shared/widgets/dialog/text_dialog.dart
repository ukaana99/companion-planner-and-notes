import 'dart:ui';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.description,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: Text(
              "Continue",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
