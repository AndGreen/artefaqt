// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Categories { series, movies, books }

enum SortModes { date, alpha, rating }

class Item {
  String id = const Uuid().v4();
  late Categories category;
  late String title;
  late String comment;
  late double rating;

  Item({
    required this.category,
    required this.title,
    required this.comment,
    required this.rating,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category =
        Categories.values.firstWhere((e) => e.toString() == json['category']);
    title = json['title'];
    comment = json['comment'];
    rating = double.parse(json['rating']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category.toString(),
        'title': title,
        'comment': comment,
        'rating': rating.toString(),
      };
}

class AppState extends ChangeNotifier {
  var selectedCategory = Categories.series;
  var sortMode = SortModes.date;
  List<Item> items = [];

  AppState() {
    restoreStorageItems().then((newItems) {
      List<Item> updatedItems = [];
      if (newItems != null && newItems.length > 0) {
        for (var item in newItems) {
          updatedItems.add(Item.fromJson(item));
        }
        items = updatedItems;
      }

      notifyListeners();
    });
  }

  List<Item> get selectedItems =>
      items.where((item) => item.category == selectedCategory).toList();

  List<Item> get sortedItems {
    switch (sortMode) {
      case SortModes.date:
        return selectedItems;
      case SortModes.alpha:
        return selectedItems..sort((a, b) => a.title.compareTo(b.title));
      case SortModes.rating:
        return selectedItems..sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  void updateSelectedCategory(Categories category) {
    selectedCategory = category;
    notifyListeners();
  }

  void changeSortMode(SortModes sortBy) {
    sortMode = sortBy;
    notifyListeners();
  }

  void saveChanges() {
    updateStorageItems(items);
    notifyListeners();
  }

  void addItem(Item newItem) {
    items.insert(0, newItem);
    saveChanges();
  }

  void updateItem(Item updatedItem) {
    items[items.indexWhere((element) => element.id == updatedItem.id)] =
        updatedItem;
    saveChanges();
  }

  void undoLastAddedItem() {
    items.removeLast();
    saveChanges();
  }

  void removeItem(String id) {
    items.removeWhere((element) => element.id == id);
    saveChanges();
  }
}
