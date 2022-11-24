import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editor_logic.dart';

class EditorHeader extends StatelessWidget {
  const EditorHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'Новое объявление',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class EditorUI extends StatelessWidget {
  const EditorUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      child: Column(
        children: const [
          Text('EditorUI'),
        ],
      ),
    );
  }
}

class VisibilityPicker extends StatelessWidget {
  const VisibilityPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorLogic>(
      builder: (context, logic, _) {
        return Column(
          children: [
            Text(
              'Выберите видимость:',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            CheckboxListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['students'],
              title: Text(
                'Студентам',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('students', value ?? false);
              },
            ),
            CheckboxListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['parents'],
              title: Text(
                'Родителям',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('parents', value ?? false);
              },
            ),
            CheckboxListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['teachers'],
              title: Text(
                'Преподавателям',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('teachers', value ?? false);
              },
            ),
          ],
        );
      },
    );
  }
}

class DialogButtons extends StatelessWidget {
  const DialogButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: context.watch<EditorLogic>().publishButtonActive
              ? context.read<EditorLogic>().publishAnnouncement
              : null,
          child: const Text('Продолжить'),
        ),
      ],
    );
  }
}
