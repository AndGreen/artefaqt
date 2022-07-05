// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/item.dart';

class GlobalState extends ChangeNotifier {
  var selectedCategory = Categories.series;
  var sortMode = SortModes.date;

  updateSelectedCategory(Categories category) {
    selectedCategory = category;
    notifyListeners();
  }

  changeSortMode(SortModes sortBy) {
    sortMode = sortBy;
    notifyListeners();
  }
}
