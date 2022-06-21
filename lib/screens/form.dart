import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const headerHeight = 52.0;

class NewEntityForm extends StatefulWidget {
  const NewEntityForm({Key? key}) : super(key: key);

  @override
  State<NewEntityForm> createState() => _NewEntityFormState();
}

class _NewEntityFormState extends State<NewEntityForm> {
  final _formKey = GlobalKey<FormState>();

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
                                autofocus: true,
                                placeholder: 'Artefaqt name',
                                style: const TextStyle(color: Colors.white),
                              )),
                        ]),
                    const SizedBox(height: 20),
                    CupertinoButton.filled(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Processing Data'),
                            ),
                          );

                          Navigator.of(context).pop();
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
