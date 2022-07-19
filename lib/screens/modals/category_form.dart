import 'package:artefaqt/components/material_cupertino_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/item.dart';
import '../../state/user.dart';

const headerHeight = 52.0;

class NewCategoryForm extends StatefulWidget {
  final Category? category;
  const NewCategoryForm({Key? key, this.category}) : super(key: key);

  @override
  State<NewCategoryForm> createState() => _NewCategoryFormState();
}

class FormData {
  String id = '';
  String title = '';
}

class _NewCategoryFormState extends State<NewCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  var data = FormData();

  @override
  void initState() {
    if (widget.category != null) {
      data.id = widget.category?.id ?? data.id;
      data.title = widget.category?.title ?? data.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userContext = context.watch<UserState>();
    return MaterialCupertinoScaffold(
      isForm: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(headerHeight),
          child: SizedBox(
              height: headerHeight,
              child: CupertinoNavigationBar(
                leading: Container(),
                middle: Text(widget.category != null
                    ? 'Edit collection'
                    : 'New collection'),
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
                            backgroundColor: Colors.transparent,
                            margin: const EdgeInsets.all(0),
                            children: [
                              CupertinoFormRow(
                                  prefix: const Text(
                                    'Title',
                                  ),
                                  child: CupertinoTextFormFieldRow(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    onChanged: (String? value) {
                                      data.title = value ?? '';
                                    },
                                    initialValue: data.title,
                                    autofocus: true,
                                    placeholder: 'Collection name',
                                  )),
                            ]),
                        const SizedBox(height: 20),
                        CupertinoButton.filled(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (data.title.isNotEmpty) {
                                if (widget.category != null) {
                                  var updatedCategory = widget.category;
                                  updatedCategory?.id = data.id;
                                  updatedCategory?.title = data.title;
                                  if (updatedCategory != null) {
                                    userContext.updateCategory(updatedCategory);
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
                          child:
                              Text(widget.category != null ? 'Update' : 'Add'),
                        )
                      ])))),
    );
  }
}
