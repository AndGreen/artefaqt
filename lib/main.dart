import 'package:artefaqt/blocs/bloc/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:artefaqt/screens/detail_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:artefaqt/screens/main_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppWidget();
}

class MyAppWidget extends State<MyApp> {
  double _rotation = 0;

  @override
  void initState() {
    _rotation = 0;
    _updateRotation();
    super.initState();
  }

  void _updateRotation() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _rotation += 0.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CategoriesBloc(),
        child: MaterialApp(
            title: 'welcome',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case '/':
                  return MaterialWithModalsPageRoute(
                      settings: settings,
                      builder: (context) => const MainView());

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
