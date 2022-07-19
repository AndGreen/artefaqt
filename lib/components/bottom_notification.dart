import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showBottomNotification(
    {required BuildContext context,
    required String message,
    required bool isSuccess}) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
    flushbarStyle: FlushbarStyle.GROUNDED,
    backgroundColor: isSuccess ? Colors.green : Colors.red,
  ).show(context);
}
