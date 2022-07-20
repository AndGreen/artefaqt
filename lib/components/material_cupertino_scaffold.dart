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
    final isLightTheme = theme.brightness == Brightness.light;

    return CupertinoTheme(
      data: CupertinoThemeData(
        primaryColor: theme.primaryColor,
      ),
      child: Scaffold(
          backgroundColor: isForm != null && isLightTheme
              ? CupertinoColors.extraLightBackgroundGray
              : theme.backgroundColor,
          body: body,
          appBar: appBar,
          drawer: drawer,
          floatingActionButton: floatingActionButton),
    );
  }
}
