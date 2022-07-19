import 'package:artefaqt/screens/settings.dart';
import 'package:artefaqt/services/database.dart';
import 'package:artefaqt/state/global.dart';
import 'package:artefaqt/state/user.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:artefaqt/screens/detail.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:artefaqt/screens/list.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHiveDatabase();

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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GlobalState>(
            create: (context) => GlobalState(),
          ),
          ChangeNotifierProvider<UserState>(
              create: (context) => UserState(context: context))
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
            theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
            darkTheme: FlexThemeData.dark(
                scheme: FlexScheme.deepBlue,
                background: const Color(0xFF292929)),
            themeMode: ThemeMode.system));
  }
}
