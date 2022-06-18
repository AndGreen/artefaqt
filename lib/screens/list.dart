import 'package:artefaqt/components/drawer.dart';
import 'package:artefaqt/model.dart';
import 'package:flutter/material.dart';
import 'package:artefaqt/components/app_bar.dart';
import 'package:artefaqt/utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

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
              builder: (context) => Container(),
            );
          },
          child: const Icon(Icons.add),
        ),
        drawer: const CustomDrawer(),
        appBar: const CustomAppBar(
          showMenuButton: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: context.watch<AppState>().selectedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: (() {
                  Navigator.pushNamed(context, '/detail');
                }),
                child: ListTile(
                    title: Text(
                        context.watch<AppState>().selectedItems[index].title)));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
