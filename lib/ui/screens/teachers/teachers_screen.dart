import 'package:flutter/material.dart';

import '../../../utils/theme_helper.dart';
import '../settings/settings_logic.dart';
import 'teachers_ui.dart';

class TeacherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
        brightness:
            ThemeHelper.isDarkMode() ? Brightness.dark : Brightness.light,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            BuildChips(),
            BuildTeachersList(),
          ],
        ),
      ),
      floatingActionButton:
          SettingsLogic.checkIsInEditMode ? EditModeFAB() : null,
    );
  }
}
