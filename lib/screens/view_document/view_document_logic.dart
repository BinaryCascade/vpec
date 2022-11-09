import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/utils/hive_helper.dart';
import '/utils/theme_helper.dart';

class ViewDocumentLogic {
  static ColorFilter get documentColorFilter {
    const ColorFilter lightThemeFilter = ColorFilter.matrix([
      //R G  B  A  Const
      0.96078, 0, 0, 0, 0,
      0, 0.96078, 0, 0, 0,
      0, 0, 0.96078, 0, 0,
      0, 0, 0, 1, 0,
    ]);

    const ColorFilter darkThemeFilter = ColorFilter.matrix([
      //R G  B  A  Const
      -0.87843, 0, 0, 0, 255,
      0, -0.87843, 0, 0, 255,
      0, 0, -0.87843, 0, 255,
      0, 0, 0, 1, 0,
    ]);

    return HiveHelper.getValue('alwaysLightThemeDocument') ??
            !ThemeHelper.isDarkMode
        ? lightThemeFilter
        : ThemeHelper.isDarkMode
            ? darkThemeFilter
            : lightThemeFilter;
  }

  static Future<String> getMDText(String url) async {
    String text = await http.read(Uri.parse(url));

    return utf8.decode(text.codeUnits);
  }

  static String getFileExtension(String path) {
    return path.split('/').last.split('.').last.split('?').first.toLowerCase();
  }

  static bool isThisURLSupported(String url) {
    List<String> supportedExtensions = ['pdf', 'md'];

    return supportedExtensions.contains(getFileExtension(url));
  }

  static Future<Uint8List> getPDFData(String url) async {
    return await http.readBytes(Uri.parse(url));
  }
}
