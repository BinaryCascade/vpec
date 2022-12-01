import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/hive_helper.dart';
import '../../../utils/theme_helper.dart';
import '../../settings/settings_logic.dart';
import 'editor_logic.dart';
import 'editor_ui.dart';

class AnnouncementEditor extends StatefulWidget {
  const AnnouncementEditor({Key? key}) : super(key: key);

  @override
  State<AnnouncementEditor> createState() => _AnnouncementEditorState();
}

class _AnnouncementEditorState extends State<AnnouncementEditor> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (HiveHelper.getValue('username') == null ||
          HiveHelper.getValue('username') == '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(minutes: 1),
          action: SnackBarAction(
            label: 'Указать имя',
            onPressed: () => SettingsLogic.changeName(context),
          ),
          content: Text(
            'Для того, чтобы отправить объявление, необходимо указать имя',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    return ChangeNotifierProvider<EditorLogic>(
      create: (_) => EditorLogic(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: EditorHeader(),
                  ),
                  EditorUI(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: VisibilityPicker(),
                  ),
                  DialogButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
