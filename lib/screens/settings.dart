import 'package:artefaqt/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
              settingsListBackground: Theme.of(context).canvasColor),
          sections: [
            SettingsSection(
              title: const Text('Data'),
              tiles: <SettingsTile>[
                SettingsTile(
                  // leading: const Icon(Icons.arrow_upward),
                  onPressed: (context) => {},
                  title: const Text('Backup to file'),
                ),
                SettingsTile(
                  // leading: const Icon(Icons.arrow_downward),
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
