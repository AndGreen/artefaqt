part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class ChangeCategoriesEvent extends CategoriesEvent {
  final Categories category;
  const ChangeCategoriesEvent({required this.category});
}
