part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final Categories selectedCategory;

  const CategoriesState({required this.selectedCategory});

  factory CategoriesState.initial() =>
      const CategoriesState(selectedCategory: Categories.movies);

  @override
  List<Object> get props => [selectedCategory];

  @override
  bool get stringify => true;

  CategoriesState copyWith({
    Categories? selectedCategory,
  }) {
    return CategoriesState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
