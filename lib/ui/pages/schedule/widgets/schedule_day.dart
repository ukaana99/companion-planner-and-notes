part of '../schedule_page.dart';

class ScheduleDay extends StatelessWidget {
  const ScheduleDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _ScheduleDayPicker(),
      body: _ScheduleDayList(),
    );
  }
}

class _ScheduleDayPicker extends StatelessWidget
    implements PreferredSizeWidget {
  const _ScheduleDayPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final controller =
        ScrollController(initialScrollOffset: 0.38 * screenWidth);

    return Material(
      elevation: 0.75,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).backgroundColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 68,
            child: ListView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: [
                _ScheduleDayItem(color: Theme.of(context).primaryColor),
                _ScheduleDayItem(color: Theme.of(context).secondaryColor),
                _ScheduleDayItem(color: Theme.of(context).tertiaryColor),
                _ScheduleDayItem(color: Theme.of(context).quaternaryColor),
                _ScheduleDayItem(color: Theme.of(context).primaryColor),
                _ScheduleDayItem(color: Theme.of(context).secondaryColor),
                _ScheduleDayItem(color: Theme.of(context).tertiaryColor),
                _ScheduleDayItem(color: Theme.of(context).quaternaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

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

class _ScheduleDayList extends StatelessWidget {
  const _ScheduleDayList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            // color: Theme.of(context).backgroundOverlay,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < 24; i++)
                  i % 6 == 0
                      ? Column(
                          children: [
                            _ScheduleIcon(hour: (i + 6) % 24),
                            __ScheduleDayListItem(hour: (i + 6) % 24),
                          ],
                        )
                      : __ScheduleDayListItem(hour: (i + 6) % 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class __ScheduleDayListItem extends StatelessWidget {
  const __ScheduleDayListItem({
    Key? key,
    required this.hour,
  }) : super(key: key);

  final int hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 72,
              child: Text(
                "$hour:00",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 72,
              // child: Text(
              //   "${(hour + 6) % 24}:00",
              // ),
            ),
          ),
        ],
      ),
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
