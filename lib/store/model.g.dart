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
