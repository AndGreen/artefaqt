import 'package:artefaqt/blocs/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../model.dart';

BlocBuilder _tile(
    {required String title,
    required IconData icon,
    required Categories category}) {
  return BlocBuilder<CategoriesBloc, CategoriesState>(
    builder: (context, state) {
      return ListTile(
        horizontalTitleGap: 8,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        title: Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            )),
        trailing: state.selectedCategory == category
            ? const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              )
            : const Spacer(),
        selected: state.selectedCategory == category,
        selectedColor: Colors.white,
        selectedTileColor: Colors.grey[800],
        onTap: () {
          context
              .read<CategoriesBloc>()
              .add(ChangeCategoriesEvent(category: category));
          Scaffold.of(context).closeDrawer();
        },
        leading: Icon(
          icon,
          size: 22,
        ),
      );
    },
  );
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return ListView(
          children: [
            const SizedBox(
                height: 64.0,
                child: DrawerHeader(
                  margin: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      // color: Colors.blue

                      ),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Artefaqt',
                          style: TextStyle(color: Colors.grey, fontSize: 16))),
                )),
            _tile(
                title: 'Series',
                icon: Ionicons.tv_sharp,
                category: Categories.series),
            _tile(
                title: 'Movies',
                icon: Icons.movie,
                category: Categories.movies),
            _tile(
                title: 'Books',
                icon: Ionicons.book_sharp,
                category: Categories.books),
          ],
        );
      },
    ));
  }
}
