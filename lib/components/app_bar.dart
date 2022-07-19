import 'package:artefaqt/state/global.dart';
import 'package:artefaqt/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, this.title}) : super(key: key);

  final String? title;

  Widget sortModeIcon(SortModes sortMode) {
    Map<SortModes, IconData> icons = {
      SortModes.date: Icons.calendar_month,
      SortModes.alpha: Icons.sort_by_alpha,
      SortModes.rating: Icons.star,
    };

    return Icon(icons[sortMode], size: 25);
  }

  @override
  Widget build(BuildContext context) {
    var sortMode = context.watch<GlobalState>().sortMode;

    return CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        trailing: GestureDetector(
            onTap: () {
              context.read<GlobalState>().changeSortMode(sortMode.toogle());
            },
            child: sortModeIcon(sortMode)),
        leading: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(Ionicons.menu_outline)),
        ),
        middle: Text(
          context.watch<GlobalState>().selectedCategory.title.toCapitalized(),
          overflow: TextOverflow.ellipsis,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
