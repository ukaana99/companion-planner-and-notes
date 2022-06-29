part of '../schedule_page.dart';

class ScheduleDayPicker extends StatelessWidget implements PreferredSizeWidget {
  const ScheduleDayPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final controller =
    //     ScrollController(initialScrollOffset: 0.38 * screenWidth);
    final currentDate =
        context.select((ScheduleCubit bloc) => bloc.state.currentDate);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Theme.of(context).primaryColor)),
      ),
      child: Column(
        children: [
          DatePicker(
            currentDate.subtract(const Duration(days: 2)),
            initialSelectedDate: currentDate,
            selectionColor: Theme.of(context).primaryColor,
            selectedTextColor: Colors.white,
            dayTextStyle:
                TextStyle(fontSize: 12, color: Theme.of(context).textColor),
            monthTextStyle:
                TextStyle(fontSize: 12, color: Theme.of(context).textColor),
            dateTextStyle:
                TextStyle(fontSize: 24, color: Theme.of(context).textColor),
            daysCount: 7,
            onDateChange: context.read<ScheduleCubit>().setCurrentDate,
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 16),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(16),
          //     child: SizedBox(
          //       height: 68,
          //       child: ListView(
          //         controller: controller,
          //         scrollDirection: Axis.horizontal,
          //         children: [
          //           _ScheduleDayItem(color: Theme.of(context).primaryColor),
          //           _ScheduleDayItem(color: Theme.of(context).secondaryColor),
          //           _ScheduleDayItem(color: Theme.of(context).tertiaryColor),
          //           _ScheduleDayItem(color: Theme.of(context).quaternaryColor),
          //           _ScheduleDayItem(color: Theme.of(context).primaryColor),
          //           _ScheduleDayItem(color: Theme.of(context).secondaryColor),
          //           _ScheduleDayItem(color: Theme.of(context).tertiaryColor),
          //           _ScheduleDayItem(color: Theme.of(context).quaternaryColor),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Text(
          //   // DateFormat('EEEE').format(DateTime.now()),
          //   'Today',
          //   style: Theme.of(context).textTheme.headline2,
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

// ignore: unused_element
class _ScheduleDayItem extends StatelessWidget {
  const _ScheduleDayItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

class ScheduleDayList extends StatelessWidget {
  const ScheduleDayList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities =
        context.select((ScheduleBloc bloc) => bloc.state.activities);
    final Map<int, List<Activity>> mappedActivities = {
      for (var e in List.generate(24, (index) => index)) e: []
    };
    for (var activity in activities) {
      mappedActivities[activity.dateTime!.hour]?.add(activity);
    }

    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < 24; i++)
                i % 6 == 0
                    ? Column(
                        children: [
                          _ScheduleIcon(hour: i % 24),
                          _ActivityItem(
                            hour: i % 24,
                            activities: mappedActivities[i]!,
                          ),
                        ],
                      )
                    : _ActivityItem(
                        hour: i % 24,
                        activities: mappedActivities[i]!,
                      ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    Key? key,
    required this.hour,
    required this.activities,
  }) : super(key: key);

  final int hour;
  final List<Activity> activities;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 72,
            child: Text(
              "$hour:00",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        if (activities.isEmpty)
          Expanded(
            flex: 4,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: Theme.of(context).backgroundOverlay,
                height: 72),
          )
        else
          Expanded(
            flex: 4,
            child: Column(
              children: [
                for (var activity in activities)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: colorFromString(activity.colorHex!).withOpacity(0.2),
                    height: 72,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: colorFromString(activity.colorHex!),
                          ),
                        ),
                        Expanded(
                          flex: 39,
                          child: ListTile(
                            onTap: () => Navigator.pushNamed(
                                context, AppRouter.activity,
                                arguments: {'activity': activity}),
                            title: Text(
                              activity.title!.isNotEmpty
                                  ? activity.title!
                                  : 'Untitled',
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              activity.description!.isNotEmpty
                                  ? activity.description!
                                  : 'No description available',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
      ],
    );
  }
}

class _ScheduleIcon extends StatelessWidget {
  const _ScheduleIcon({
    Key? key,
    required this.hour,
  }) : super(key: key);

  final int hour;

  IconData get mapHourToWidget {
    switch (hour) {
      case 0:
        return FontAwesomeIcons.solidMoon;
      case 6:
        return FontAwesomeIcons.cloudSun;
      case 12:
        return FontAwesomeIcons.solidSun;
      case 18:
        return FontAwesomeIcons.cloudMoon;
      default:
        return FontAwesomeIcons.solidSun;
    }
  }

  String get mapHourToString {
    switch (hour) {
      case 0:
        return "AM";
      case 6:
        return "AM";
      case 12:
        return "PM";
      case 18:
        return "PM";
      default:
        return "PM";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Icon(
            mapHourToWidget,
            color: Theme.of(context).hintColor,
          ),
          const SizedBox(width: 16),
          Text(mapHourToString, style: Theme.of(context).textTheme.headline2)
        ],
      ),
    );
  }
}
