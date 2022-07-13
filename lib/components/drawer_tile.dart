import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../screens/modals/category_form.dart';
import '../state/global.dart';
import '../state/user.dart';
import 'edit_action_pane.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key? key,
    required this.id,
    required this.title,
    required this.category,
    required this.selected,
  }) : super(key: key);

  final String id;
  final String title;
  final Category category;
  final bool selected;
  // late IconData icon;

  @override
  Widget build(BuildContext context) {
    return EditActionPane(
        onEdit: () {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (context) => NewCategoryForm(
                category:
                    context.read<UserState>().userData.categories.firstWhere(
                          (element) => element.id == id,
                        )),
          );
        },
        onDelete: () {
          context.read<UserState>().removeCategory(id);
        },
        child: ListTile(
          horizontalTitleGap: 8,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          title: Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              )),
          trailing: selected
              ? const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              : const SizedBox.shrink(), // Just empty Widget
          selected: selected,
          selectedColor: Colors.white,
          selectedTileColor: Colors.grey[800],
          onTap: () {
            context.read<GlobalState>().updateSelectedCategory(category);
            Navigator.pop(context);
          },
        ));
  }
}
