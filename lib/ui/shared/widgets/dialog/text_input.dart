import 'package:flutter/material.dart';
import '../../../../app/app_theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    this.initialValue = '',
    this.hintText,
    this.onChanged,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.enabled,
  }) : super(key: key);

  final String? initialValue;
  final String? hintText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundOverlay,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: TextFormField(
          enabled: enabled,
          initialValue: initialValue,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(color: Theme.of(context).textColor),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
