// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/screens/modals/category_form.dart';
import 'package:artefaqt/state/user.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:artefaqt/utils.dart';

import '../models/item.dart';
import '../state/global.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    required this.category,
  }) : super(key: key);

  final String title;
  final Category category;
  // late IconData icon;

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
      trailing: context.watch<GlobalState>().selectedCategory == category
          ? const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          : const SizedBox.shrink(), // Just empty Widget
      selected: context.watch<GlobalState>().selectedCategory == category,
      selectedColor: Colors.white,
      selectedTileColor: Colors.grey[800],
      onTap: () {
        context.read<GlobalState>().updateSelectedCategory(category);
        Navigator.pop(context);
      },
      // TODO: return icons
      // leading: Icon(
      //   icon,
      //   size: 22,
      // ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categories = context.watch<UserState>().userData.categories;
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
              height: 64.0,
              child: DrawerHeader(
                margin: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    // color: Colors.blue

                    ),
                child: Center(
                    child: Text('Artefaqt',
                        style: TextStyle(color: Colors.grey, fontSize: 16))),
              )),
          ...categories
              .map((e) => Tile(category: e, title: e.title.toCapitalized())),
          TextButton.icon(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => const NewCategoryForm(),
                );
              },
              icon: const Icon(Ionicons.add_circle_outline),
              label: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("New category", textAlign: TextAlign.left),
              ))
        ],
      ),
    );
  }
}
