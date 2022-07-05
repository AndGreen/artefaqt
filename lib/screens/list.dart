// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:artefaqt/components/app_bar.dart';
import 'package:artefaqt/components/drawer.dart';
import 'package:artefaqt/screens/form.dart';
import 'package:artefaqt/utils.dart';

import '../models/item.dart';
import '../state/items.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  static List<int> colorCodes = <int>[600, 500, 100];

  static Categories selectedCategory = Categories.series;
  static String selectedTitle =
      selectedCategory.toString().split('.').last.toCapitalized();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) => const NewEntityForm(),
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
          child: ListView.separated(
            itemCount:
                context.watch<ItemsState>().getSortedItems(context).length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onLongPress: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => NewEntityForm(
                          item: context
                              .read<ItemsState>()
                              .getSortedItems(context)[index]),
                    );
                  },
                  onTap: (() {
                    Navigator.pushNamed(context, '/detail',
                        arguments: DetailArguments(
                            item: context
                                .read<ItemsState>()
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
                                  .read<ItemsState>()
                                  .getSelectedItems(context)[index]
                                  .id;
                              context.read<ItemsState>().removeItem(id);
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
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(children: [
                          Expanded(
                              child: Text(context
                                  .watch<ItemsState>()
                                  .getSortedItems(context)[index]
                                  .title)),
                          Row(children: [
                            Text(context
                                .watch<ItemsState>()
                                .getSelectedItems(context)[index]
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
        ));
  }
}
