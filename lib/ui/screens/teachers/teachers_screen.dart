import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpec/ui/screens/teachers/teachers_logic.dart';

import '../../../utils/theme_helper.dart';
import '../settings/settings_logic.dart';
import 'teachers_ui.dart';

class TeacherScreen extends StatefulWidget {
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);
    return Consumer<TeachersLogic>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: value.isSearchMode ? SearchBar() : Text('Преподаватели'),
            actions: [SearchButton()],
            brightness:
                ThemeHelper.isDarkMode() ? Brightness.dark : Brightness.light,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                AnimatedSize(
                    vsync: this,
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(milliseconds: 400),
                    reverseDuration: Duration(milliseconds: 400),
                    child: value.isSearchMode ? BuildChips() : Container()),
                BuildTeachersList(),
              ],
            ),
          ),
          floatingActionButton:
              SettingsLogic.checkIsInEditMode ? EditModeFAB() : null,
        );
      },
    );
  }
}
