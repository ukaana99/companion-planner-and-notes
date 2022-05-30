import 'package:flutter/material.dart';
import '../../../../app/app_theme.dart';

class SelectionInput extends StatelessWidget {
  const SelectionInput({
    Key? key,
    required this.items,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  final String? hintText;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

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
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText,
            isDense: true,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
