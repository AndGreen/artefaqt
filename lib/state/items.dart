import 'package:artefaqt/services/database.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';
import 'global.dart';

class ItemsState extends ChangeNotifier {
  List<Item> items = [];
  late GlobalState _globalState;
  late Database _database;

  ItemsState({GlobalState? globalState, required Database database}) {
    if (globalState != null) {
      _globalState = globalState;
    }
    _database = database;
    _restoreItems();
  }

  _restoreItems() async {
    var newItems = await restoreDatabaseItems(_database);
    if (newItems != null) {
      items = newItems;
      notifyListeners();
    }
  }

  _saveItems() {
    updateDatabaseItems(_database, items);
    notifyListeners();
  }

  List<Item> _getSelectedItems(BuildContext context) => items
      .where((item) => item.category == _globalState.selectedCategory)
      .toList();

  List<Item> getSortedItems(BuildContext context) {
    switch (_globalState.sortMode) {
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
    items.insert(0, newItem);
    _saveItems();
  }

  updateItem(Item updatedItem) {
    items[items.indexWhere((element) => element.id == updatedItem.id)] =
        updatedItem;
    _saveItems();
  }

  undoLastAddedItem() {
    items.removeLast();
    _saveItems();
  }

  removeItem(String id) {
    items.removeWhere((element) => element.id == id);
    _saveItems();
  }
}
