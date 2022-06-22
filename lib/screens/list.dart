// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:artefaqt/components/app_bar.dart';
import 'package:artefaqt/components/drawer.dart';
import 'package:artefaqt/model.dart';
import 'package:artefaqt/screens/form.dart';
import 'package:artefaqt/utils.dart';

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
        body: ListView.separated(
          // TODO: padding: const EdgeInsets.all(8),
          itemCount: context.watch<AppState>().selectedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: (() {
                  Navigator.pushNamed(context, '/detail',
                      arguments: DetailArguments(
                          item: context.read<AppState>().selectedItems[index]));
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
                                .read<AppState>()
                                .selectedItems[index]
                                .id;
                            context.read<AppState>().removeItem(id);
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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Expanded(
                            child: Text(context
                                .watch<AppState>()
                                .selectedItems[index]
                                .title)),
                        Row(children: [
                          Text(context
                              .watch<AppState>()
                              .selectedItems[index]
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
              const Divider(),
        ));
  }
}
