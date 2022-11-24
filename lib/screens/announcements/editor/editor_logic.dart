import 'package:flutter/material.dart';

class EditorLogic extends ChangeNotifier {
  /// Shows, should publish button be active or disabled.
  bool publishButtonActive = false;

  /// List of publish privacy
  Map<String, bool> publishFor = {
    'students': false,
    'parents': false,
    'teachers': false,
  };

  /// Use for update values from checkboxes in [publishFor]
  void updateCheckbox(final String changeFor, final bool newValue) {
    publishFor.update(changeFor, (_) => newValue);
    checkAndUpdatePublishButtonActiveStatus();
  }

  /// Checks for user selected privacy for creating article, and if nothing
  /// was selected, then disables button.
  void checkAndUpdatePublishButtonActiveStatus() {
    bool publishCategoryWasSelected = false;

    publishFor.forEach((key, value) {
      if (value) publishCategoryWasSelected = true;
    });

    publishButtonActive = publishCategoryWasSelected;
    notifyListeners();
  }

  void publishAnnouncement() {}
}
