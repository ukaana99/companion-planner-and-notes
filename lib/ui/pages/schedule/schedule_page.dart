import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_theme.dart';

part 'widgets/schedule_day.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
        onPressed: () {},
      ),
      body: const ScheduleDay(),
    );
  }
}
