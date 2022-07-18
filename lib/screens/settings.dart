import 'package:another_flushbar/flushbar.dart';
import 'package:artefaqt/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../state/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: Container(
        color: Theme.of(context).canvasColor,
        child: SettingsList(
          contentPadding: const EdgeInsets.all(0),
          darkTheme: SettingsThemeData(
              dividerColor: Theme.of(context).canvasColor,
              settingsSectionBackground:
                  Theme.of(context).inputDecorationTheme.fillColor,
              settingsListBackground: Theme.of(context).canvasColor),
          sections: [
            SettingsSection(
              // title: const Text('Data'),
              tiles: <SettingsTile>[
                SettingsTile(
                  // leading: const Icon(Icons.arrow_upward),
                  onPressed: (context) {
                    context.read<UserState>().saveDataToFile();
                  },
                  title: const Text('Backup to file'),
                ),
                SettingsTile(
                  // leading: const Icon(Icons.arrow_downward),
                  onPressed: (context) async {
                    var res = await context
                        .read<UserState>()
                        .restoreDataFromFile(context);

                    if (!mounted) return;
                    if (res != null) {
                      if (!res) {
                        Flushbar(
                          // title: "Not corrected file",
                          message: "Not corrected backup file",
                          duration: const Duration(seconds: 3),
                          flushbarStyle: FlushbarStyle.GROUNDED,
                          backgroundColor: Colors.red,
                        ).show(context);
                      }
                      if (res) {
                        Flushbar(
                          // title: "Not corrected file",
                          message: "Backup restored",
                          duration: const Duration(seconds: 3),
                          flushbarStyle: FlushbarStyle.GROUNDED,
                          backgroundColor: Colors.green,
                        ).show(context);
                      }
                    }
                  },
                  title: const Text('Restore backup'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
