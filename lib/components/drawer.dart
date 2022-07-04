// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../store/model.dart';
import '../store/store.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.category,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Categories category;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          )),
      trailing:
          context.watch<AppStateCubit>().state.selectedCategory == category
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              : const SizedBox.shrink(), // Just empty Widget
      selected:
          context.watch<AppStateCubit>().state.selectedCategory == category,
      selectedColor: Colors.white,
      selectedTileColor: Colors.grey[800],
      onTap: () {
        context.read<AppStateCubit>().updateSelectedCategory(category);
        Navigator.pop(context);
      },
      leading: Icon(
        icon,
        size: 22,
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: const [
        SizedBox(
            height: 64.0,
            child: DrawerHeader(
              margin: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                  // color: Colors.blue

                  ),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Artefaqt',
                      style: TextStyle(color: Colors.grey, fontSize: 16))),
            )),
        Tile(
            title: 'Series',
            icon: Ionicons.tv_sharp,
            category: Categories.series),
        Tile(title: 'Movies', icon: Icons.movie, category: Categories.movies),
        Tile(
            title: 'Books',
            icon: Ionicons.book_sharp,
            category: Categories.books),
      ],
    ));
  }
}
