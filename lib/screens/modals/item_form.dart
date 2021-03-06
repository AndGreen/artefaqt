import 'package:artefaqt/state/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../components/material_cupertino_scaffold.dart';
import '../../models/item.dart';
import '../../state/user.dart';

const headerHeight = 52.0;

class ItemForm extends StatefulWidget {
  const ItemForm({Key? key, this.item, this.title}) : super(key: key);

  final Item? item;
  final String? title;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class FormData {
  String title = '';
  String comment = '';
  double rating = 0;
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  var data = FormData();

  @override
  void initState() {
    if (widget.title != null) {
      data.title = widget.title!;
    }
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
    return MaterialCupertinoScaffold(
      isForm: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(headerHeight),
          child: SizedBox(
              height: headerHeight,
              child: CupertinoNavigationBar(
                leading: Container(),
                middle: Text(
                  widget.item != null ? 'Edit artefaqt' : 'New artefaqt',
                ),
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
                                  prefix: const Text('Title'),
                                  child: CupertinoTextFormFieldRow(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    onChanged: (String? value) {
                                      data.title = value ?? '';
                                    },
                                    initialValue: data.title,
                                    autofocus: true,
                                    placeholder: 'Artefaqt name',
                                  )),
                              CupertinoFormRow(
                                  prefix: const Text('Comment'),
                                  child: CupertinoTextFormFieldRow(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 12,
                                    minLines: 1,
                                    onChanged: (String? value) {
                                      data.comment = value ?? '';
                                    },
                                    initialValue: data.comment,
                                    autofocus: true,
                                    placeholder: 'Your expressions',
                                  )),
                              CupertinoFormRow(
                                  prefix: const Text('Raiting'),
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
                                      Icons.star_rounded,
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
