import 'package:artefaqt/components/add_button.dart';
import 'package:artefaqt/components/edit_action_pane.dart';
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

import '../components/treasure_map.dart';
import '../models/item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String? _filterInput;
  late final _textController = TextEditingController(text: _filterInput);

  clearFilter() {
    setState(() {
      _filterInput = null;
    });
    _textController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void didChangeDependencies() {
    clearFilter();
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
                  builder: (context) => const ItemForm(),
                );
              },
              child: const Icon(Icons.add),
            ),
            drawer: const CustomDrawer(),
            appBar: const CustomAppBar(
              showMenuButton: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (items.isEmpty && _filterInput == null) const TreasureMap(),
                if (items.isNotEmpty || _filterInput != null)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CupertinoSearchTextField(
                      controller: _textController,
                      placeholder: 'Filter',
                      onSuffixTap: () {
                        clearFilter();
                      },
                      onChanged: (value) {
                        setState(() {
                          _filterInput = value;
                        });
                      },
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                if (items.isEmpty && _filterInput != null)
                  AddButton(
                    title: "Add $_filterInput",
                    onPressed: () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => ItemForm(title: _filterInput),
                      );
                    },
                  ),
                Expanded(
                  child: SlidableAutoCloseBehavior(
                    closeWhenOpened: true,
                    closeWhenTapped: true,
                    child: Scrollbar(
                      child: ListView.separated(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return EditActionPane(
                            extentRatio: 0.45,
                            onEdit: () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    ItemForm(item: items[index]),
                              );
                            },
                            onDelete: () {
                              var id = items[index].id;
                              context.read<UserState>().removeItem(id);
                            },
                            child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, '/detail',
                                      arguments:
                                          DetailArguments(item: items[index]));
                                },
                                title: Padding(
                                  padding: index == 0
                                      ? const EdgeInsets.only(
                                          top: 14, bottom: 20)
                                      : const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                  child: Row(children: [
                                    Expanded(child: Text(items[index].title)),
                                    Row(children: [
                                      if (items[index].rating > 0)
                                        Text(items[index].rating.toString()),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6),
                                          child: Icon(items[index].rating > 0
                                              ? Icons.star_rounded
                                              : Icons.star_border_rounded))
                                    ])
                                  ]),
                                )),
                          );
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
