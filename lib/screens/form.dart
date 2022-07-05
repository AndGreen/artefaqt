import 'package:artefaqt/state/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../state/items.dart';

const headerHeight = 52.0;

class NewEntityForm extends StatefulWidget {
  final Item? item;
  const NewEntityForm({Key? key, this.item}) : super(key: key);

  @override
  State<NewEntityForm> createState() => _NewEntityFormState();
}

class _NewEntityFormState extends State<NewEntityForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _comment = '';
  double _rating = 0;

  late ItemsState _context;

  @override
  void initState() {
    if (widget.item != null) {
      _title = widget.item?.title ?? _title;
      _comment = widget.item?.comment ?? _comment;
      _rating = widget.item?.rating ?? _rating;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _context = context.read<ItemsState>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
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
                                      _title = value ?? '';
                                    },
                                    initialValue: _title,
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
                                      _comment = value ?? '';
                                    },
                                    initialValue: _comment,
                                    autofocus: true,
                                    placeholder: 'Your expressions',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                              CupertinoFormRow(
                                  prefix: const Text('Raiting',
                                      style: TextStyle(color: Colors.white)),
                                  child: RatingBar.builder(
                                    initialRating: _rating,
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
                                      _rating = rating;
                                    },
                                  ))
                            ]),
                        const SizedBox(height: 20),
                        CupertinoButton.filled(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final snackBar = SnackBar(
                                backgroundColor: const Color(0xff262626),
                                content: const Text(
                                  'All done!',
                                  style: TextStyle(color: Colors.white),
                                ),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    _context.undoLastAddedItem();
                                  },
                                ),
                              );

                              if (_title.isNotEmpty) {
                                if (widget.item != null) {
                                  var updatedItem = widget.item;
                                  updatedItem?.title = _title;
                                  updatedItem?.rating = _rating;
                                  updatedItem?.comment = _comment;
                                  if (updatedItem != null) {
                                    context
                                        .read<ItemsState>()
                                        .updateItem(updatedItem);
                                  }
                                } else {
                                  var newItem = Item(
                                      title: _title,
                                      comment: _comment,
                                      rating: _rating,
                                      category: context
                                          .read<GlobalState>()
                                          .selectedCategory);

                                  context.read<ItemsState>().addItem(newItem);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }

                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Text(widget.item != null ? 'Update' : 'Add'),
                        )
                      ])))),
    ));
  }
}
