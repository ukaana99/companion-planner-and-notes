import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import '../../../../app/app_theme.dart';

class TimeInput extends StatelessWidget {
  const TimeInput({
    Key? key,
    required this.value,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  final DateTime value;
  final String? hintText;
  final void Function(DateTime)? onChanged;

  @override
  Widget build(BuildContext context) {
    final text = DateFormat('HH : mm').format(value);
    final TextEditingController controller = TextEditingController(text: text);
    final TimeOfDay time = TimeOfDay(hour: value.hour, minute: value.minute);

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundOverlay,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: time,
              builder: (BuildContext context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: Theme.of(context)
                          .primaryColor, // header background color
                      onPrimary: Colors.white, // header text color
                      surface: Theme.of(context).backgroundColor,

                      onSurface: Theme.of(context).textColor, // body text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary:
                            Theme.of(context).primaryColor, // button text color
                      ),
                    ),
                    dialogBackgroundColor: Theme.of(context).backgroundColor,
                    timePickerTheme: TimePickerThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      child: child!,
                    ),
                  ),
                );
              },
            );
            final newTime = picked ?? time;
            final deadline = DateTime(value.year, value.month, value.day,
                newTime.hour, newTime.minute);
            controller.text = DateFormat('hh : mm').format(deadline);
            onChanged!(deadline);
          },
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(color: Theme.of(context).textColor),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: hintText,
            isDense: true,
            icon: Icon(
              Icons.access_time,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ),
    );
  }
}
