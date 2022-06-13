import 'package:artefaqt/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: (const Center(child: Text("Hello")))),
      appBar: const CustomAppBar(title: 'Detail View'),
    );
  }
}
