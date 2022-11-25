import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme_helper.dart';
import 'editor_logic.dart';
import 'editor_ui.dart';

class AnnouncementEditor extends StatefulWidget {
  const AnnouncementEditor({Key? key}) : super(key: key);

  @override
  State<AnnouncementEditor> createState() => _AnnouncementEditorState();
}

class _AnnouncementEditorState extends State<AnnouncementEditor> {
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
