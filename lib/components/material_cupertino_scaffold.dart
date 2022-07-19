import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialCupertinoScaffold extends StatelessWidget {
  const MaterialCupertinoScaffold(
      {Key? key,
      this.body,
      this.appBar,
      this.drawer,
      this.floatingActionButton,
      this.isForm})
      : super(key: key);

  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final bool? isForm;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CupertinoTheme(
        data: CupertinoThemeData(
          primaryColor: theme.primaryColor,
        ),
        child: Scaffold(
            backgroundColor:
                isForm != null && theme.brightness == Brightness.light
                    ? const Color(0xffF2F2F6)
                    : theme.backgroundColor,
            body: body,
            appBar: appBar,
            drawer: drawer,
            floatingActionButton: floatingActionButton));
  }
}
