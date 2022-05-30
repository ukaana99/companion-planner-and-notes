import 'package:flutter/material.dart';

import '../colors.dart';

class ColorListPicker extends StatelessWidget {
  const ColorListPicker({
    Key? key,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);
 
 
  final Color selectedColor;
  final Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: MaterialButton(
                  onPressed: () {},
                  color: selectedColor,
                  shape: const CircleBorder(side: BorderSide.none),
                ),
              ),
              const SizedBox(width: 12),
              Text('Color',
                  style: TextStyle(color: Theme.of(context).hintColor)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            direction: Axis.horizontal,
            children: appColors.map((color) {
              return SizedBox(
                width: 24,
                height: 24,
                child: MaterialButton(
                  onPressed: () => onColorSelected(color),
                  color: color,
                  shape: const CircleBorder(side: BorderSide.none),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
