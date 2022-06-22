import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

const storageItemsKeys = 'items';

Future<dynamic> restoreStorageItems() async {
  final prefs = await SharedPreferences.getInstance();
  final str = prefs.getString(storageItemsKeys) ?? "";
  return json.decode(str);
}

void updateStorageItems(List<Item> items) async {
  final prefs = await SharedPreferences.getInstance();
  var str = json.encode(items);
  print(str);
  await prefs.setString(storageItemsKeys, str);
}
