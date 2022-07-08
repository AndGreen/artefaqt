import 'package:artefaqt/screens/detail.dart';
import 'package:artefaqt/state/global.dart';
import 'package:artefaqt/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:artefaqt/components/app_bar.dart';
import 'package:artefaqt/components/drawer.dart';
import 'package:artefaqt/screens/modals/item_form.dart';

import '../models/item.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  static List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    var selectedCategory = context.watch<GlobalState>().selectedCategory;
    context.watch<UserState>().userData;

    return selectedCategory.id == loadingId
        ? Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const Center(child: CircularProgressIndicator()))
        : Scaffold(
            // backgroundColor: Colors.black,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => const NewItemForm(),
                );
              },
              child: const Icon(Icons.add),
            ),
            drawer: const CustomDrawer(),
            appBar: const CustomAppBar(
              showMenuButton: true,
            ),
            body: SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              closeWhenTapped: true,
              child: Scrollbar(
                child: ListView.separated(
                  itemCount:
                      context.watch<UserState>().getSortedItems(context).length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onLongPress: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => NewItemForm(
                                item: context
                                    .read<UserState>()
                                    .getSortedItems(context)[index]),
                          );
                        },
                        onTap: (() {
                          Navigator.pushNamed(context, '/detail',
                              arguments: DetailArguments(
                                  item: context
                                      .read<UserState>()
                                      .getSortedItems(context)[index]));
                        }),
                        child: Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              extentRatio: 0.25,
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    var id = context
                                        .read<UserState>()
                                        .getSortedItems(context)[index]
                                        .id;
                                    context.read<UserState>().removeItem(id);
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                                title: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(children: [
                                Expanded(
                                    child: Text(context
                                        .watch<UserState>()
                                        .getSortedItems(context)[index]
                                        .title)),
                                Row(children: [
                                  Text(context
                                      .watch<UserState>()
                                      .getSortedItems(context)[index]
                                      .rating
                                      .toString()),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Icon(Icons.star))
                                ])
                              ]),
                            ))));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 1),
                ),
              ),
            ));
  }
}
