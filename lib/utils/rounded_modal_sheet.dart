import 'package:flutter/material.dart';

/// creating modal sheet with rounded corners
Future<void> roundedModalSheet(
    {required BuildContext context,
    required String title,
    bool isDismissible = true,
    bool enableDrag = true,
    required Widget child}) async {
  await showModalBottomSheet(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) => Container(
            margin: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Center(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                child,
              ],
            ),
          ));
}
