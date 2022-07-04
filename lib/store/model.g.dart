// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      category: $enumDecode(_$CategoriesEnumMap, json['category']),
      title: json['title'] as String,
      comment: json['comment'] as String,
      rating: (json['rating'] as num).toDouble(),
    )..id = json['id'] as String;

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'category': _$CategoriesEnumMap[instance.category],
      'title': instance.title,
      'comment': instance.comment,
      'rating': instance.rating,
    };

const _$CategoriesEnumMap = {
  Categories.series: 'series',
  Categories.movies: 'movies',
  Categories.books: 'books',
};

GlobalState _$GlobalStateFromJson(Map<String, dynamic> json) => GlobalState(
      selectedCategory:
          $enumDecode(_$CategoriesEnumMap, json['selectedCategory']),
      sortMode: $enumDecode(_$SortModesEnumMap, json['sortMode']),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlobalStateToJson(GlobalState instance) =>
    <String, dynamic>{
      'selectedCategory': _$CategoriesEnumMap[instance.selectedCategory],
      'sortMode': _$SortModesEnumMap[instance.sortMode],
      'items': instance.items,
    };

const _$SortModesEnumMap = {
  SortModes.date: 'date',
  SortModes.alpha: 'alpha',
  SortModes.rating: 'rating',
};
