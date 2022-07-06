import 'package:hive_flutter/hive_flutter.dart';

import '../models/item.dart';

const storageItemsKeys = 'items';

typedef Database = Box<dynamic>;

Future<Database> initDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(SortModesAdapter());
  return await Hive.openBox('appDB');
}

Future<List<Item>?> restoreDatabaseItems(Database database) async {
  var a = database.get(storageItemsKeys, defaultValue: []);
  return a.cast<Item>();
}

void updateDatabaseItems(Database database, List<Item> items) async {
  database.put(storageItemsKeys, items);
}
