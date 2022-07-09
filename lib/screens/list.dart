import 'package:artefaqt/screens/detail.dart';
import 'package:artefaqt/state/global.dart';
import 'package:artefaqt/state/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:artefaqt/components/app_bar.dart';
import 'package:artefaqt/components/drawer.dart';
import 'package:artefaqt/screens/modals/item_form.dart';

import '../models/item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String? _filterInput;
  late final _textController = TextEditingController(text: _filterInput);

  @override
  void didChangeDependencies() {
    print('UPDATED');
    _filterInput = null;
    _textController.clear();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var selectedCategory = context.watch<GlobalState>().selectedCategory;
    context.watch<UserState>().userData;

    var items =
        context.watch<UserState>().getFilteredItems(_textController.text);

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
            body: Column(
              children: [
                if (items.isNotEmpty || _filterInput != null)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CupertinoSearchTextField(
                      controller: _textController,
                      placeholder: 'Filter',
                      onChanged: (value) {
                        setState(() {
                          _filterInput = value;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                Expanded(
                  child: SlidableAutoCloseBehavior(
                    closeWhenOpened: true,
                    closeWhenTapped: true,
                    child: Scrollbar(
                      child: ListView.separated(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onLongPress: () {
                                showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      NewItemForm(item: items[index]),
                                );
                              },
                              onTap: (() {
                                Navigator.pushNamed(context, '/detail',
                                    arguments:
                                        DetailArguments(item: items[index]));
                              }),
                              child: Slidable(
                                  key: ValueKey(index),
                                  endActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          var id = items[index].id;
                                          context
                                              .read<UserState>()
                                              .removeItem(id);
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                      title: Padding(
                                    padding: index == 0
                                        ? const EdgeInsets.only(
                                            top: 14, bottom: 20)
                                        : const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                    child: Row(children: [
                                      Expanded(child: Text(items[index].title)),
                                      Row(children: [
                                        Text(items[index].rating.toString()),
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
                  ),
                ),
              ],
            ));
  }
}
