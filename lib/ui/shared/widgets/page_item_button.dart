import 'package:flutter/material.dart';

class PageItemButton extends StatelessWidget {
  const PageItemButton({
    Key? key,
    this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData? icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        child: SizedBox.expand(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Text(title),
              const SizedBox(width: 24),
            ],
          ),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
