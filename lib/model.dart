// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum Categories { series, movies, books }

class Item {
  late Categories category;
  late String title;

  Item({
    required this.category,
    required this.title,
  });
}

class AppState extends ChangeNotifier {
  var selectedCategory = Categories.series;
  List<Item> items = [];

  AppState() {
    items
        .add(Item(category: Categories.series, title: 'How I met your mother'));
    items.add(Item(category: Categories.series, title: 'House M.D'));
  }

  get selectedItems =>
      items.where((item) => item.category == selectedCategory).toList();

  void updateSelectedCategory(Categories category) {
    selectedCategory = category;
    notifyListeners();
  }
}
