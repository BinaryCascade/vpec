import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/teachers/teachers_logic.dart';
import '/utils/theme_helper.dart';
import '../../utils/firebase_auth.dart';
import 'teachers_ui.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
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
            title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: value.isSearchMode
                  ? const SearchBar()
                  : Row(
                      children: const <Widget>[
                        Text('Преподаватели'),
                      ],
                    ),
            ),
            actions: const <Widget>[SearchButton()],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                AnimatedSize(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 400),
                  reverseDuration: const Duration(milliseconds: 400),
                  child: value.isSearchMode
                      ? const FilterChips()
                      : const SizedBox(
                          width: double.infinity,
                        ),
                ),
                const BuildTeachersList(),
              ],
            ),
          ),
          floatingActionButton: AccountEditorMode().isEditorModeActive
              ? const EditModeFAB()
              : null,
        );
      },
    );
  }
}
