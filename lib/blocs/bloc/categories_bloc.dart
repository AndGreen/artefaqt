import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:artefaqt/model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState.initial()) {
    on<ChangeCategoriesEvent>((event, emit) {
      emit(CategoriesState(selectedCategory: event.category));
    });
  }
}
