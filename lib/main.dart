import 'package:artefaqt/model.dart';
import 'package:flutter/material.dart';
import 'package:artefaqt/screens/detail.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:artefaqt/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppModel(),
        child: MaterialApp(
            title: 'welcome',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/':
                  return MaterialWithModalsPageRoute(
                      settings: settings,
                      builder: (context) => const HomeView());

                case "/modal":
                  return MaterialPageRoute(
                      builder: (context) => const DetailView(),
                      fullscreenDialog: true);
              }
              return null;
            },
            routes: <String, WidgetBuilder>{
              // '/': (context) => const CupertinoScaffold(body: MainView()),
              '/detail': (context) => const DetailView()
            },
            theme: ThemeData(
              primaryColor: Colors.green,
              brightness: Brightness.dark,
            )));
    // home: const MainView());
  }
}
