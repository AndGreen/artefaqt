import 'package:artefaqt/state/global.dart';
import 'package:artefaqt/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../models/Item.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, this.title, this.showMenuButton = false})
      : super(key: key);

  final String? title;
  final bool? showMenuButton;

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

    if (showMenuButton == false) {
      return CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        backgroundColor: Colors.black45,

        middle: Text(
          title ?? 'artefaqt',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
      );
    } else {
      return CupertinoNavigationBar(
          // Try removing opacity to observe the lack of a blur effect and of sliding content.
          backgroundColor: Colors.grey[900],
          trailing: GestureDetector(
              onTap: () {
                context.read<GlobalState>().changeSortMode(sortMode.toogle());
              },
              child: sortModeIcon(sortMode)),
          leading: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(Ionicons.menu_outline)),
          middle: Text(
            context.watch<GlobalState>().selectedCategory.getTitle(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
