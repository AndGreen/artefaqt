// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:artefaqt/utils.dart';

import '../screens/modals/category_form.dart';
import '../state/global.dart';
import 'add_button.dart';
import 'drawer_tile.dart';

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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16))),
                  )),
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: ReorderableListView(
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
                      ...categories.map((e) => DrawerTile(
                          key: Key(e.id),
                          id: e.id,
                          selected:
                              context.watch<GlobalState>().selectedCategory ==
                                      e &&
                                  !isOnReorder,
                          category: e,
                          title: e.title.toCapitalized()))
                    ],
                  ),
                ),
              ),
              AddButton(
                title: "New collection",
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => const NewCategoryForm(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
