import 'package:flutter/material.dart';

class DeleteDialogUI extends StatelessWidget {
  final void Function() onDelete;

  const DeleteDialogUI({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('Удалить'),
          ),
        ),
      ],
    );
  }
}
