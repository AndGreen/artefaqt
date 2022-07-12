import 'package:artefaqt/services/database.dart';
import 'package:artefaqt/state/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/item.dart';
import 'global.dart';

var defaultCategories = [
  Category(id: const Uuid().v4(), title: 'Series'),
  Category(id: const Uuid().v4(), title: 'Movies'),
  Category(id: const Uuid().v4(), title: 'Books')
];

class UserState extends ChangeNotifier {
  late UserData userData = UserData(items: [], categories: defaultCategories);

  late GlobalState _globalState;
  late Database _database;

  UserState({required Database database, required BuildContext context}) {
    _database = database;
    _globalState = Provider.of<GlobalState>(context, listen: false);
    _restoreData();
  }

  _restoreData() async {
    var newUserData = await restoreUserData(_database);
    if (newUserData.items.isNotEmpty) userData.items = newUserData.items;
    if (newUserData.categories.isNotEmpty) {
      userData.categories = newUserData.categories;
    }
    _globalState.updateSelectedCategory(userData.categories.first);
    notifyListeners();
  }

  List<Item> _getSelectedItems() {
    return userData.items
        .where((item) => item.category.id == _globalState.selectedCategory.id)
        .toList();
  }

  List<Item> _getSortedItems() {
    switch (_globalState.sortMode) {
      case SortModes.date:
        return _getSelectedItems();
      case SortModes.alpha:
        return _getSelectedItems()..sort((a, b) => a.title.compareTo(b.title));
      case SortModes.rating:
        return _getSelectedItems()
          ..sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  List<Item> getFilteredItems(String? input) {
    return input != null
        ? _getSortedItems()
            .where((element) =>
                element.title.toLowerCase().contains(input.toLowerCase()))
            .toList()
        : _getSelectedItems();
  }

  _saveData() {
    updateUserData(_database, userData);
    notifyListeners();
  }

  addItem(Item newItem) {
    userData.items.insert(0, newItem);
    _saveData();
  }

  updateItem(Item updatedItem) {
    userData.items[userData.items
        .indexWhere((element) => element.id == updatedItem.id)] = updatedItem;
    _saveData();
  }

  removeItem(String id) {
    userData.items.removeWhere((element) => element.id == id);
    _saveData();
  }

  addCategory(Category newCategory) {
    userData.categories.add(newCategory);
    _saveData();
  }

  reorderCategories(int oldIndex, int nextIndex) {
    if (oldIndex < nextIndex) {
      nextIndex -= 1;
    }
    List<Category> newCategories = List.from(userData.categories);
    newCategories.insert(nextIndex, newCategories.removeAt(oldIndex));
    userData.categories = newCategories;
    _saveData();
  }

  updateCategory(Category updatedCategory) {
    userData.categories[userData.categories
            .indexWhere((element) => element.id == updatedCategory.id)] =
        updatedCategory;
    _saveData();
  }

  removeCategory(String id) {
    userData.categories.removeWhere((element) => element.id == id);
    userData.items.removeWhere((element) => element.category.id == id);
    _globalState.updateSelectedCategory(userData.categories.first);
    _saveData();
  }
}
