import 'package:artefaqt/blocs/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:artefaqt/utils.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key, this.title, this.showMenuButton = false})
      : super(key: key);

  final String? title;
  final bool? showMenuButton;

  @override
  Widget build(BuildContext context) {
    if (showMenuButton == false) {
      return CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        backgroundColor: Colors.black45,

        middle: Text(
          title ?? 'artefaqt',
          style: const TextStyle(color: Colors.white),
        ),
      );
    } else {
      return CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        backgroundColor: Colors.grey[900],
        trailing: const Icon(
          Icons.star,
          size: 25,
        ),
        leading: GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(Ionicons.menu_outline)),
        middle: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            return Text(
              state.selectedCategory.getTitle(),
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
