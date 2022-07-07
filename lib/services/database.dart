import 'package:hive_flutter/hive_flutter.dart';

import '../models/item.dart';

const storageItemsKey = 'items';
const storageCategoriesKey = 'categories';

typedef Database = Box<dynamic>;

Future<Database> initDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ItemAdapter());
  return await Hive.openBox('app');
}

Future<UserData> restoreUserData(Database database) async {
  var items = database.get(storageItemsKey, defaultValue: []).cast<Item>();
  var categories =
      database.get(storageCategoriesKey, defaultValue: []).cast<Category>();
  return UserData(items: items, categories: categories);
}

void updateUserData(Database database, UserData userData) async {
  database.put(storageItemsKey, userData.items);
  database.put(storageCategoriesKey, userData.categories);
}
