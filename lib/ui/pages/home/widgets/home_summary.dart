part of '../home_page.dart';

class HomeSummary extends StatelessWidget {
  const HomeSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              "Weekly Summary",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }
}
