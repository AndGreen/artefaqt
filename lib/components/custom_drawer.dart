import 'package:artefaqt/blocs/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../model.dart';

ListTile _tile(
    {required String title, required IconData icon, required bool selected}) {
  return ListTile(
    horizontalTitleGap: 8,
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        )),
    trailing: selected
        ? const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          )
        : const Spacer(),
    selected: selected,
    selectedColor: Colors.white,
    selectedTileColor: Colors.grey[800],
    leading: Icon(
      icon,
      size: 22,
    ),
  );
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: BlocBuilder<CategoriesBloc, CategoriesEvent>(
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
                selected: selectedCategory == Categories.series),
            _tile(
                title: 'Movies',
                icon: Icons.movie,
                selected: selectedCategory == Categories.movies),
            _tile(
                title: 'Books',
                icon: Ionicons.book_sharp,
                selected: selectedCategory == Categories.books),
          ],
        );
      },
    ));
  }
}
