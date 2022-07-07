import 'package:artefaqt/services/database.dart';
import 'package:artefaqt/state/global.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/item.dart';
import 'global.dart';

var defaultCategories = [
  Category(id: const Uuid().v4(), title: 'Series'),
  Category(id: const Uuid().v4(), title: 'Movies'),
  Category(id: const Uuid().v4(), title: 'books')
];

class UserState extends ChangeNotifier {
  UserData userData = UserData(items: [], categories: defaultCategories);

  GlobalState? _globalState;
  late Database _database;

  UserState({GlobalState? globalState, required Database database}) {
    if (globalState != null) {
      _globalState = globalState;
    }
    _database = database;
    _restoreData();
  }

  _restoreData() async {
    var newUserData = await restoreUserData(_database);
    if (newUserData.items.isNotEmpty) userData.items = newUserData.items;
    if (newUserData.categories.isNotEmpty) {
      userData.categories = newUserData.categories;
    }
    if (_globalState != null &&
        _globalState?.selectedCategory.id == loadingId) {
      _globalState?.updateSelectedCategory(userData.categories.first);
    }
    notifyListeners();
  }

  _saveItems() {
    updateUserData(_database, userData);
    notifyListeners();
  }

  List<Item> _getSelectedItems(BuildContext context) {
    return userData.items
        .where((item) => item.category.id == _globalState?.selectedCategory.id)
        .toList();
  }

  List<Item> getSortedItems(BuildContext context) {
    switch (_globalState?.sortMode) {
      case null:
      case SortModes.date:
        return _getSelectedItems(context);
      case SortModes.alpha:
        return _getSelectedItems(context)
          ..sort((a, b) => a.title.compareTo(b.title));
      case SortModes.rating:
        return _getSelectedItems(context)
          ..sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  addItem(Item newItem) {
    userData.items.insert(0, newItem);
    _saveItems();
  }

  updateItem(Item updatedItem) {
    userData.items[userData.items
        .indexWhere((element) => element.id == updatedItem.id)] = updatedItem;
    _saveItems();
  }

  undoLastAddedItem() {
    userData.items.removeLast();
    _saveItems();
  }

  removeItem(String id) {
    userData.items.removeWhere((element) => element.id == id);
    _saveItems();
  }
}
