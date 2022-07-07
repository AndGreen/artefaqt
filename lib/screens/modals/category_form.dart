import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/item.dart';
import '../../state/user.dart';

const headerHeight = 52.0;

class NewCategoryForm extends StatefulWidget {
  final Item? item;
  const NewCategoryForm({Key? key, this.item}) : super(key: key);

  @override
  State<NewCategoryForm> createState() => _NewCategoryFormState();
}

class FormData {
  String title = '';
}

class _NewCategoryFormState extends State<NewCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  var data = FormData();

  @override
  void initState() {
    if (widget.item != null) {
      data.title = widget.item?.title ?? data.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userContext = context.watch<UserState>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(headerHeight),
          child: SizedBox(
              height: headerHeight,
              child: CupertinoNavigationBar(
                backgroundColor: const Color(0xff262626),
                leading: Container(),
                middle: Text(
                    widget.item != null ? 'Edit category' : 'New category',
                    style: const TextStyle(color: Colors.white)),
              ))),
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CupertinoFormSection.insetGrouped(
                            decoration: BoxDecoration(
                              color: const Color(0xff262626),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.transparent,
                            margin: const EdgeInsets.all(0),
                            children: [
                              CupertinoFormRow(
                                  prefix: const Text('Title',
                                      style: TextStyle(color: Colors.white)),
                                  child: CupertinoTextFormFieldRow(
                                    onChanged: (String? value) {
                                      data.title = value ?? '';
                                    },
                                    initialValue: data.title,
                                    autofocus: true,
                                    placeholder: 'Category name',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                            ]),
                        const SizedBox(height: 20),
                        CupertinoButton.filled(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (data.title.isNotEmpty) {
                                if (widget.item != null) {
                                  var updatedItem = widget.item;
                                  updatedItem?.title = data.title;
                                  if (updatedItem != null) {
                                    userContext.updateItem(updatedItem);
                                  }
                                } else {
                                  var newCategory = Category(
                                    id: const Uuid().v4(),
                                    title: data.title,
                                  );

                                  userContext.addCategory(newCategory);
                                }

                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Text(widget.item != null ? 'Update' : 'Add'),
                        )
                      ])))),
    );
  }
}