import 'dart:convert';
import 'dart:io';

import 'package:artefaqt/services/database.dart';
import 'package:artefaqt/state/global.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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

  UserState({required BuildContext context}) {
    _globalState = Provider.of<GlobalState>(context, listen: false);
    _restoreDataHive();
  }

  _restoreDataHive() async {
    var newUserData = await restoreUserData();
    if (newUserData.items.isNotEmpty) userData.items = newUserData.items;
    if (newUserData.categories.isNotEmpty) {
      userData.categories = newUserData.categories;
    }
    _globalState.updateSelectedCategory(userData.categories.first);
    notifyListeners();
  }

  saveDataToFile() async {
    Directory documents = await getApplicationDocumentsDirectory();
    File backupFile = File('${documents.path}/backup.json');
    var json = serializeUserDataToString();
    await backupFile.writeAsString(json);
    await Share.shareFiles([backupFile.path]);
  }

  restoreDataFromFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        File file = File(result.files.single.path!);
        var json = await file.readAsString();
        var data = UserData.fromJson(jsonDecode(json));
        userData = data;
        _saveData();
        return true;
      } catch (e) {
        return false;
      }
    }
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
    updateUserData(userData);
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
