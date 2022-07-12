// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/screens/modals/category_form.dart';
import 'package:artefaqt/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:artefaqt/utils.dart';

import '../models/item.dart';
import '../state/global.dart';

class Tile extends StatelessWidget {
  const Tile({
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
    return Slidable(
      key: ValueKey(id),
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
              onPressed: (context) {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => NewCategoryForm(
                      category: context
                          .read<UserState>()
                          .userData
                          .categories
                          .firstWhere(
                            (element) => element.id == id,
                          )),
                );
              },
              backgroundColor: const Color.fromARGB(255, 84, 84, 84),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit'),
          SlidableAction(
            onPressed: (context) {
              context.read<UserState>().removeCategory(id);
            },
            backgroundColor: const Color(0xfffe604d),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
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
        // onLongPress: () {
        //   showCupertinoModalBottomSheet(
        //     context: context,
        //     builder: (context) => NewCategoryForm(
        //         category:
        //             context.read<UserState>().userData.categories.firstWhere(
        //                   (element) => element.id == id,
        //                 )),
        //   );
        // },
        onTap: () {
          context.read<GlobalState>().updateSelectedCategory(category);
          Navigator.pop(context);
        },
        // TODO: return icons
        // leading: Icon(
        //   icon,
        //   size: 22,
        // ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var isOnReorder = false;
  @override
  Widget build(BuildContext context) {
    var categories = context.watch<UserState>().userData.categories;

    return Drawer(
      child: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        closeWhenTapped: true,
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
            ReorderableListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              onReorderStart: (int index) {
                setState(() {
                  isOnReorder = true;
                });
              },
              onReorder: (int oldIndex, int nextIndex) {
                context
                    .read<UserState>()
                    .reorderCategories(oldIndex, nextIndex);

                isOnReorder = false;
              },
              children: [
                ...categories.map((e) => Tile(
                    key: Key(e.id),
                    id: e.id,
                    selected:
                        context.watch<GlobalState>().selectedCategory == e &&
                            !isOnReorder,
                    category: e,
                    title: e.title.toCapitalized()))
              ],
            ),
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
      ),
    );
  }
}
