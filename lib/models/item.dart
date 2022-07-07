// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'item.g.dart';

enum SortModes { date, alpha, rating }

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
}

const loadingId = 'loading';

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
}

class UserData {
  late List<Item> items;
  late List<Category> categories;
  UserData({
    required this.items,
    required this.categories,
  });
}
