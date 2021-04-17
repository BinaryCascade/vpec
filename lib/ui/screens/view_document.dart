import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../models/document_model.dart';
import '../../utils/hive_helper.dart';
import '../../utils/theme_helper.dart';
import '../widgets/loading_indicator.dart';

class DocumentViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocumentModel doc = ModalRoute.of(context).settings.arguments;
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
    // we don't need weird nulls (can be null if user type url by himself)
    if (doc == null) {
      Navigator.popAndPushNamed(context, '/');
    }

    ColorFilter darkModeFilter() {
      if (HiveHelper().getValue('alwaysLightThemeDocument')) {
        return ColorFilter.matrix([
          0.96078, 0, 0, 0, 0,
          0, 0.96078, 0, 0, 0,
          0, 0, 0.96078, 0, 0,
          0, 0, 0, 1, 0,
        ]);
      } else {
        return ThemeHelper().isDarkMode()
            ? ColorFilter.matrix([
                //R G  B  A  Const
                -0.87843, 0, 0, 0, 255,
                0, -0.87843, 0, 0, 255,
                0, 0, -0.87843, 0, 255,
                0, 0, 0, 1, 0,
              ])
            : ColorFilter.matrix([
                0.96078, 0, 0, 0, 0,
                0, 0.96078, 0, 0, 0,
                0, 0, 0.96078, 0, 0,
                0, 0, 0, 1, 0,
              ]);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(doc.title)),
      body: Center(
        child: ColorFiltered(
          colorFilter: darkModeFilter(),
          child: PDF(swipeHorizontal: true)
              .fromUrl(doc.url, placeholder: (progress) => LoadingIndicator()),
        ),
      ),
    );
  }
}
