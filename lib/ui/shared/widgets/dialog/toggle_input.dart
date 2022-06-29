import 'package:flutter/material.dart';

class ToggleInput extends StatelessWidget {
  const ToggleInput({
    Key? key,
    this.value = false,
    this.hintText = '',
    this.onChanged,
  }) : super(key: key);

  final bool value;
  final String hintText;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hintText,
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            Switch(value: value, onChanged: onChanged)
          ],
        ),
      ),
    );
  }
}
