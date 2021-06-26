import 'package:flutter/material.dart';

class DeleteDialogUI extends StatelessWidget {
  final void Function() onDelete;

  const DeleteDialogUI({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: Theme.of(context).outlinedButtonTheme.style,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Отмена',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: Theme.of(context).outlinedButtonTheme.style,
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: Text(
              'Удалить',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color),
            ),
          ),
        ),
      ],
    );
  }
}
