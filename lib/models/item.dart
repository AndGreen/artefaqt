import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
enum Categories {
  @HiveField(0)
  series,
  @HiveField(1)
  movies,
  @HiveField(2)
  books
}

@HiveType(typeId: 2)
enum SortModes {
  @HiveField(0)
  date,
  @HiveField(1)
  alpha,
  @HiveField(2)
  rating
}

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  String id = const Uuid().v4();
  @HiveField(1)
  late Categories category;
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
}
