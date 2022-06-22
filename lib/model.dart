// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:artefaqt/storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Categories { series, movies, books }

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
