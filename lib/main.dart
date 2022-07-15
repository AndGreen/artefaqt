import 'package:artefaqt/screens/settings.dart';
import 'package:artefaqt/services/database.dart';
import 'package:artefaqt/state/global.dart';
import 'package:artefaqt/state/user.dart';
import 'package:flutter/material.dart';
import 'package:artefaqt/screens/detail.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:artefaqt/screens/list.dart';
import 'package:provider/provider.dart';

void main() async {
  var db = await initDatabase();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  return runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  final Database database;
  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GlobalState>(
            create: (context) => GlobalState(),
          ),
          ChangeNotifierProvider<UserState>(
              create: (context) =>
                  UserState(database: database, context: context))
        ],
        child: MaterialApp(
            title: 'welcome',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/':
                  return MaterialWithModalsPageRoute(
                      settings: settings,
                      builder: (context) => const ListScreen());
              }
              return null;
            },
            routes: <String, WidgetBuilder>{
              '/detail': (context) => const DetailScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
            theme: ThemeData(
              primaryColor: Colors.green,
              inputDecorationTheme:
                  const InputDecorationTheme(fillColor: Color(0xff262626)),
              textTheme:
                  const TextTheme(bodyText2: TextStyle(color: Colors.white)),
              brightness: Brightness.dark,
            )));
  }
}
