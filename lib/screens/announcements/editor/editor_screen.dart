import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider<EditorLogic>(
      create: (_) => EditorLogic(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: EditorHeader(),
                ),
                EditorUI(),
                VisibilityPicker(),
                DialogButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
