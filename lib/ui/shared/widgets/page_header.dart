import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    this.title,
    this.description,
    this.color,
  }) : super(key: key);

  final String? title;
  final String? description;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      // padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        // color: color ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 8.0,
                backgroundColor: color ?? Colors.white,
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  title!.isNotEmpty ? title! : 'Untitled',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textColor,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 8.0,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description!.isNotEmpty ? description! : 'No description available',
          ),
        ],
      ),
    );
  }
}
