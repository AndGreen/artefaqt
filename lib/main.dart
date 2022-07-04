import 'package:artefaqt/store/store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:artefaqt/screens/detail.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:artefaqt/screens/list.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppStateCubit(),
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
          )),
    );
  }
}
