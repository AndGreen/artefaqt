import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/item.dart';

const itemsKey = 'items';
const categoriesKey = 'categories';

typedef Database = Box<dynamic>;

Future<bool> initHiveDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ItemAdapter());
  var db = await Hive.openBox('app');
  GetIt.I.registerLazySingleton<Database>(() => db);
  return Future.value(true);
}

Future<UserData> restoreUserData() async {
  var database = GetIt.I<Database>();
  var items = database.get(itemsKey, defaultValue: []).cast<Item>();
  var categories =
      database.get(categoriesKey, defaultValue: []).cast<Category>();
  return UserData(items: items, categories: categories);
}

void updateUserData(UserData userData) async {
  var database = GetIt.I<Database>();
  database.put(itemsKey, userData.items);
  database.put(categoriesKey, userData.categories);
}

String serializeUserDataToString() {
  var database = GetIt.I<Database>();
  var items = database.get(itemsKey);
  var categories = database.get(categoriesKey);

  return jsonEncode({itemsKey: items, categoriesKey: categories});
}
