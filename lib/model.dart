import 'package:flutter/material.dart';

enum Categories { series, movies, books }

class AppModel extends ChangeNotifier {
  Categories selectedCategory = Categories.series;

  void updateSelectedCategory(Categories category) {
    selectedCategory = category;
    notifyListeners();
  }
}
