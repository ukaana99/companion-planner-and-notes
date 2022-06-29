import 'dart:ui';
import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  const FormDialog({
    Key? key,
    required this.title,
    required this.children,
    required this.onPressed,
    this.cancelLabel = 'Cancel',
    this.confirmLabel = 'Confirm',
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final String cancelLabel;
  final String confirmLabel;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        insetPadding: const EdgeInsets.all(24),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Center(child: Text(title, style: const TextStyle(fontSize: 16))),
        contentPadding: const EdgeInsets.fromLTRB(4, 20, 4, 24),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: SizedBox(
              width: 80,
              child: Center(
                child: Text(cancelLabel),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onPressed();
              Navigator.of(context).pop();
            },
            child: SizedBox(
              width: 80,
              child: Center(
                child: Text(confirmLabel),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
