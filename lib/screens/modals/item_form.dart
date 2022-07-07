import 'package:artefaqt/state/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../models/item.dart';
import '../../state/user.dart';

const headerHeight = 52.0;

class NewItemForm extends StatefulWidget {
  final Item? item;
  const NewItemForm({Key? key, this.item}) : super(key: key);

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class FormData {
  String title = '';
  String comment = '';
  double rating = 0;
}

class _NewItemFormState extends State<NewItemForm> {
  final _formKey = GlobalKey<FormState>();
  var data = FormData();

  @override
  void initState() {
    if (widget.item != null) {
      data.title = widget.item?.title ?? data.title;
      data.comment = widget.item?.comment ?? data.comment;
      data.rating = widget.item?.rating ?? data.rating;
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
                    widget.item != null ? 'Edit artefaqt' : 'New artefaqt',
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
                                    placeholder: 'Artefaqt name',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              CupertinoFormRow(
                                  prefix: const Text('Comment',
                                      style: TextStyle(color: Colors.white)),
                                  child: CupertinoTextFormFieldRow(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 12,
                                    minLines: 1,
                                    onChanged: (String? value) {
                                      data.comment = value ?? '';
                                    },
                                    initialValue: data.comment,
                                    autofocus: true,
                                    placeholder: 'Your expressions',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              CupertinoFormRow(
                                  prefix: const Text('Raiting',
                                      style: TextStyle(color: Colors.white)),
                                  child: RatingBar.builder(
                                    initialRating: data.rating,
                                    minRating: 0,
                                    glow: false,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      data.rating = rating;
                                    },
                                  ))
                            ]),
                        const SizedBox(height: 20),
                        CupertinoButton.filled(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (data.title.isNotEmpty) {
                                if (widget.item != null) {
                                  var updatedItem = widget.item;
                                  updatedItem?.title = data.title;
                                  updatedItem?.rating = data.rating;
                                  updatedItem?.comment = data.comment;
                                  if (updatedItem != null) {
                                    userContext.updateItem(updatedItem);
                                  }
                                } else {
                                  var newItem = Item(
                                      title: data.title,
                                      comment: data.comment,
                                      rating: data.rating,
                                      category: context
                                          .read<GlobalState>()
                                          .selectedCategory);

                                  userContext.addItem(newItem);
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
