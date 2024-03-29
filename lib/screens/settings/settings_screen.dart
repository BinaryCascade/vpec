import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/styled_widgets.dart';
import '../../utils/firebase_auth.dart';
import '../../utils/theme/theme.dart';
import '../../utils/theme_helper.dart';
import '../../widgets/system_bar_cover.dart';
import 'settings_logic.dart';
import 'settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorSystemChrome();

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SystemNavBarCover(
        height: MediaQuery.of(context).padding.bottom,
      ),
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Card(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AccountEditorMode()),
                ChangeNotifierProvider(create: (_) => SettingsLogic()),
              ],
              builder: (context, child) => const AccountBlock(),
            ),
          ),
          const AppThemeListTile(),
          const LaunchOnStartChooser(),
          const Divider(),
          StyledListTile(
            icon: Icon(
              Icons.info_outlined,
              size: 32,
              color: context.palette.accentColor,
            ),
            title: 'О приложении',
            subtitle: 'Просмотреть техническую информацию',
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
        ],
      ),
    );
  }
}
