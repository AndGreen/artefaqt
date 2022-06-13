part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeCategoriesEvent extends CategoriesEvent {}
