import 'package:artefaqt/components/custom_drawer.dart';
import 'package:artefaqt/model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:artefaqt/components/CustomAppBar.dart';
import 'package:artefaqt/utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  static List<String> entries = <String>['A', 'B', 'C'];
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
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: (() {
                  Navigator.pushNamed(context, '/detail');
                }),
                child:
                    ListTile(title: Text('$selectedTitle ${entries[index]}')));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
