import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);

  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Ionicons.add_circle_outline),
        label: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(title, textAlign: TextAlign.left),
        ));
  }
}
