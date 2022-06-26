import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_theme.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundOverlay,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: TextField(
          // controller: _controller,
          // onTap: () => model.useSearch(true),
          style: TextStyle(
            color: Theme.of(context).textColor,
          ),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: "Search",
            icon: Icon(
              Icons.search,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
