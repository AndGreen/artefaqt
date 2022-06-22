import 'package:artefaqt/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const headerHeight = 52.0;

class NewEntityForm extends StatefulWidget {
  const NewEntityForm({Key? key}) : super(key: key);

  @override
  State<NewEntityForm> createState() => _NewEntityFormState();
}

class _NewEntityFormState extends State<NewEntityForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _comment = '';

  late AppState _context;

  @override
  void didChangeDependencies() {
    _context = context.read<AppState>();
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
                      middle: const Text('New artefaqt',
                          style: TextStyle(color: Colors.white)),
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
                                autofocus: true,
                                placeholder: 'Your expressions',
                                style: const TextStyle(color: Colors.white),
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
                            var newItem = Item(
                                title: _title,
                                comment: _comment,
                                category:
                                    context.read<AppState>().selectedCategory);

                            context.read<AppState>().addItem(newItem);

                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
