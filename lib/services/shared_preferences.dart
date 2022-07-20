import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

const isOnboardingPref = 'isOnboarded';

Future<bool> initSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton<SharedPreferences>(() => prefs);
  return Future.value(true);
}
