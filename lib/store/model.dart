import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum Categories { series, movies, books }

enum SortModes { date, alpha, rating }

@JsonSerializable()
class Item {
  String id = const Uuid().v4();
  late Categories category;
  late String title;
  late String comment;
  late double rating;

  Item({
    required this.category,
    required this.title,
    required this.comment,
    required this.rating,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
