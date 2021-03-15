import 'package:flutter/material.dart';

void roundedModalSheet(
    {@required BuildContext context, String title, Widget child}) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) => Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                child,
              ],
            ),
          ));
}
