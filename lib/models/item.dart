import 'package:uuid/uuid.dart';

enum Categories { series, movies, books }

enum SortModes { date, alpha, rating }

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

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category =
        Categories.values.firstWhere((e) => e.toString() == json['category']);
    title = json['title'];
    comment = json['comment'];
    rating = double.parse(json['rating']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category.toString(),
        'title': title,
        'comment': comment,
        'rating': rating.toString(),
      };
}
