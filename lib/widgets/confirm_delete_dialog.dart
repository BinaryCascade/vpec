import 'package:flutter/material.dart';

class DeleteDialogUI extends StatelessWidget {
  final void Function() onDelete;

  const DeleteDialogUI({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              child: const Text('Удалить'),
            ),
          ),
        ),
      ],
    );
  }
}
