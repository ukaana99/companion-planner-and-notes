import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

part 'widgets/home_summary.dart';
part 'widgets/home_schedule.dart';
part 'widgets/home_projects.dart';
part 'widgets/home_tasks.dart';
part 'widgets/home_notes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SizedBox(height: 20),
          HomeSchedule(),
          HomeSummary(),
          HomeProjects(),
          HomeTasks(),
          HomeNotes(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
