import 'package:flutter/material.dart';

import '../../../utils/hive_helper.dart';
import '../../../utils/theme_helper.dart';

class ViewDocumentLogic {
  static ColorFilter documentColorFilter() {
    if (HiveHelper.getValue('alwaysLightThemeDocument') == null) {
      HiveHelper.saveValue(key: 'alwaysLightThemeDocument', value: false);
    }
    if (HiveHelper.getValue('alwaysLightThemeDocument')) {
      return const ColorFilter.matrix([
        //R G  B  A  Const
        0.96078, 0, 0, 0, 0,
        0, 0.96078, 0, 0, 0,
        0, 0, 0.96078, 0, 0,
        0, 0, 0, 1, 0,
      ]);
    } else {
      return ThemeHelper.isDarkMode()
          ? const ColorFilter.matrix([
              //R G  B  A  Const
              -0.87843, 0, 0, 0, 255,
              0, -0.87843, 0, 0, 255,
              0, 0, -0.87843, 0, 255,
              0, 0, 0, 1, 0,
            ])
          : const ColorFilter.matrix([
              //R G  B  A  Const
              0.96078, 0, 0, 0, 0,
              0, 0.96078, 0, 0, 0,
              0, 0, 0.96078, 0, 0,
              0, 0, 0, 1, 0,
            ]);
    }
  }
}
