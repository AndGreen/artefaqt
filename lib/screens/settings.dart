import 'package:artefaqt/components/material_cupertino_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../components/bottom_notification.dart';
import '../state/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialCupertinoScaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text(
          'Settings',
        ),
      ),
      body: SettingsList(
        contentPadding: const EdgeInsets.all(0),
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
                    if (res) {
                      showBottomNotification(
                          context: context,
                          message: "Backup restored",
                          isSuccess: true);
                    } else {
                      showBottomNotification(
                          context: context,
                          message: "Not corrected backup file",
                          isSuccess: false);
                    }
                  }
                },
                title: const Text('Restore backup'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
