import 'package:flutter/material.dart';

void roundedModalSheet(
    {BuildContext context, String title, Widget contentChild}) {
  showModalBottomSheet(
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
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                contentChild,
              ],
            ),
          ));
}
