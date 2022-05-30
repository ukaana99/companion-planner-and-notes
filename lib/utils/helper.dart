import 'package:flutter/material.dart';

String createdSince(DateTime dateTime) {
  final diff = DateTime.now().difference(dateTime);
  if (diff.inDays > 356) {
    return (diff.inDays % 356).toString() + 'y';
  } else if (diff.inDays > 30) {
    return (diff.inDays % 30).toString() + 'm';
  } else if (diff.inDays > 0) {
    return diff.inDays.toString() + 'd';
  } else if (diff.inHours > 0) {
    return diff.inHours.toString() + 'h';
  } else if (diff.inMinutes > 0) {
    return diff.inMinutes.toString() + 'min';
  } else {
    return 'just now';
  }
}

String colorToString(Color color) => color.toString().substring(6, 16);
Color colorFromString(String string) => Color(int.parse(string));
