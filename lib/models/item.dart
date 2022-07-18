// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'item.g.dart';

typedef Json = Map<String, dynamic>;

enum SortModes { date, alpha, rating }

@JsonSerializable()
@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String? iconName;

  Category({
    required this.id,
    required this.title,
    this.iconName,
  });

  factory Category.fromJson(Json json) => _$CategoryFromJson(json);
  Json toJson() => _$CategoryToJson(this);
}

const loadingId = 'loading';

@JsonSerializable()
@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  String id = const Uuid().v4();
  @HiveField(1)
  late Category category;
  @HiveField(2)
  late String title;
  @HiveField(3)
  late String comment;
  @HiveField(4)
  late double rating;

  Item({
    required this.category,
    required this.title,
    required this.comment,
    required this.rating,
  });

  factory Item.fromJson(Json json) => _$ItemFromJson(json);
  Json toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class UserData {
  late List<Item> items;
  late List<Category> categories;
  UserData({
    required this.items,
    required this.categories,
  });

  factory UserData.fromJson(Json json) => _$UserDataFromJson(json);
  Json toJson() => _$UserDataToJson(this);
}
