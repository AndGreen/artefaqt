// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'model.dart';

class AppStateCubit extends HydratedCubit<GlobalState> {
  AppStateCubit()
      : super(GlobalState(
            selectedCategory: Categories.series,
            sortMode: SortModes.date,
            items: []));

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

  addItem(Item newItem) {
    emit(state.copyWith()..items.insert(0, newItem));
  }

  updateItem(Item updatedItem) {
    var newState = state.copyWith();
    newState.items[state.items
        .indexWhere((element) => element.id == updatedItem.id)] = updatedItem;
    emit(newState);
  }

  undoLastAddedItem() {
    emit(state.copyWith()..items.removeLast());
  }

  removeItem(String id) {
    emit(state.copyWith()..items.removeWhere((element) => element.id == id));
  }

  @override
  GlobalState? fromJson(Map<String, dynamic> json) {
    return GlobalState.fromJson(json['state']);
  }

  @override
  Map<String, dynamic>? toJson(GlobalState state) {
    return {'state': state.toJson()};
  }
}
