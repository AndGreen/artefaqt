// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/storage.dart';
import 'package:flutter/material.dart';

enum Categories { series, movies, books }

class Item {
  late Categories category;
  late String title;

  Item({
    required this.category,
    required this.title,
  });

  Item.fromJson(Map<String, dynamic> json) {
    category =
        Categories.values.firstWhere((e) => e.toString() == json['category']);
    title = json['title'];
  }

  Map<String, dynamic> toJson() => {
        'category': category.toString(),
        'title': title,
      };
}

class AppState extends ChangeNotifier {
  var selectedCategory = Categories.series;
  List<Item> items = [];

  AppState() {
    restoreStorageItems().then((newItems) {
      List<Item> updatedItems = [];
      for (var item in newItems) {
        updatedItems.add(Item.fromJson(item));
      }
      items = updatedItems;
      notifyListeners();
    });
  }

  get selectedItems =>
      items.where((item) => item.category == selectedCategory).toList();

  void updateSelectedCategory(Categories category) {
    selectedCategory = category;
    notifyListeners();
  }

  void addItem(Item newItem) {
    items.add(newItem);
    updateStorageItems(items);
    notifyListeners();
  }

  void undoLastAddedItem() {
    items.removeLast();
    updateStorageItems(items);
    notifyListeners();
  }
}
