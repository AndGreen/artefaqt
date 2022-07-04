import 'package:artefaqt/state/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Item.dart';
import 'global.dart';

class ItemsState extends ChangeNotifier {
  List<Item> items = [];

  ItemsState() {
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

  List<Item> getSelectedItems(BuildContext context) => items
      .where((item) =>
          item.category == Provider.of<GlobalState>(context).selectedCategory)
      .toList();

  List<Item> getSortedItems(BuildContext context) {
    switch (Provider.of<GlobalState>(context).sortMode) {
      case SortModes.date:
        return getSelectedItems(context);
      case SortModes.alpha:
        return getSelectedItems(context)
          ..sort((a, b) => a.title.compareTo(b.title));
      case SortModes.rating:
        return getSelectedItems(context)
          ..sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  _saveChanges() {
    updateStorageItems(items);
    notifyListeners();
  }

  addItem(Item newItem) {
    items.insert(0, newItem);
    _saveChanges();
  }

  updateItem(Item updatedItem) {
    items[items.indexWhere((element) => element.id == updatedItem.id)] =
        updatedItem;
    _saveChanges();
  }

  undoLastAddedItem() {
    items.removeLast();
    _saveChanges();
  }

  removeItem(String id) {
    items.removeWhere((element) => element.id == id);
    _saveChanges();
  }
}
