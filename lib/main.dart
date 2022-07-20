import 'package:artefaqt/screens/onboarding.dart';
import 'package:artefaqt/screens/settings.dart';
import 'package:artefaqt/services/database.dart';
import 'package:artefaqt/services/shared_preferences.dart';
import 'package:artefaqt/state/global.dart';
import 'package:artefaqt/state/user.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:artefaqt/screens/detail.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:artefaqt/screens/list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // -- settings up app start
  await initHiveDatabase();
  await initSharedPreferences();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  // -- settings up app finish
  FlutterNativeSplash.remove();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isOnboarded =
        GetIt.I<SharedPreferences>().getBool(isOnboardingPref) ?? false;
    final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GlobalState>(
            create: (context) => GlobalState(),
          ),
          ChangeNotifierProvider<UserState>(
              create: (context) => UserState(context: context))
        ],
        child: Container(
          // canvas background of app
          color: brightness == Brightness.light
              ? Colors.white
              : CupertinoColors.darkBackgroundGray,
          child: MaterialApp(
              title: 'welcome',
              debugShowCheckedModeBanner: false,
              initialRoute: !isOnboarded ? '/onboarding' : '/',
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
                '/onboarding': (context) => const Onboarding(),
                '/detail': (context) => const DetailScreen(),
                '/settings': (context) => const SettingsScreen(),
              },
              theme: FlexThemeData.light(scheme: FlexScheme.brandBlue),
              darkTheme: FlexThemeData.dark(
                  scheme: FlexScheme.deepBlue,
                  background: CupertinoColors.darkBackgroundGray),
              themeMode: ThemeMode.system),
        ));
  }
}
