// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:artefaqt/store/storage.dart';

import 'model.dart';

class GlobalState {
  late Categories selectedCategory;
  late SortModes sortMode;
  late List<Item> items;

  GlobalState({
    required this.selectedCategory,
    required this.sortMode,
    required this.items,
  });

  GlobalState copyWith({
    Categories? selectedCategory,
    SortModes? sortMode,
    List<Item>? items,
  }) {
    return GlobalState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      sortMode: sortMode ?? this.sortMode,
      items: items ?? this.items,
    );
  }
}

class AppStateCubit extends Cubit<GlobalState> {
  AppStateCubit(super.initialState) {
    restoreStorageItems().then((newItems) {
      List<Item> updatedItems = [];

      if (newItems != null && newItems.length > 0) {
        for (var item in newItems) {
          updatedItems.add(Item.fromJson(item));
        }
        emit(state.copyWith()..items = updatedItems);
      }
    });
  }

  List<Item> get selectedItems => state.items
      .where((item) => item.category == state.selectedCategory)
      .toList();

  List<Item> get sortedItems {
    switch (state.sortMode) {
      case SortModes.date:
        return selectedItems;
      case SortModes.alpha:
        return selectedItems..sort((a, b) => a.title.compareTo(b.title));
      case SortModes.rating:
        return selectedItems..sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  updateSelectedCategory(Categories category) {
    emit(state.copyWith()..selectedCategory = category);
  }

  changeSortMode(SortModes sortBy) {
    emit(state.copyWith()..sortMode = sortBy);
  }

  _saveChanges(GlobalState newState) {
    updateStorageItems(newState.items);
    emit(newState);
  }

  addItem(Item newItem) {
    _saveChanges(state.copyWith()..items.insert(0, newItem));
  }

  updateItem(Item updatedItem) {
    var newState = state.copyWith();
    newState.items[state.items
        .indexWhere((element) => element.id == updatedItem.id)] = updatedItem;
    _saveChanges(newState);
  }

  undoLastAddedItem() {
    _saveChanges(state.copyWith()..items.removeLast());
  }

  removeItem(String id) {
    _saveChanges(
        state.copyWith()..items.removeWhere((element) => element.id == id));
  }
}
