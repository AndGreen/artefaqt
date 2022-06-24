import 'package:artefaqt/model.dart';
import 'package:flutter/material.dart';
import 'package:artefaqt/screens/detail.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:artefaqt/screens/list.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppState(),
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
              '/detail': (context) => const DetailScreen()
            },
            theme: ThemeData(
              primaryColor: Colors.green,
              textTheme:
                  const TextTheme(bodyText2: TextStyle(color: Colors.white)),
              brightness: Brightness.dark,
            )));
  }
}
