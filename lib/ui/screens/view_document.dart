import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';

import '../../models/document_model.dart';
import '../../utils/hive_helper.dart';
import '../../utils/theme_helper.dart';

class DocumentViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocumentModel doc = ModalRoute.of(context).settings.arguments;
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
    // we don't need weird nulls (can be null if user type url by himself)
    if (doc == null) {
      Navigator.popAndPushNamed(context, '/');
    }

    bool nightMode() {
      if (HiveHelper().getValue('pdfTheme') == 'Тёмная тема') {
        return true;
      } else {
        if (HiveHelper().getValue('pdfTheme') == 'Светлая тема') {
          return false;
        } else {
          return ThemeHelper().isDarkMode();
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(doc.title)),
      body: Center(
        child:
            PDF(swipeHorizontal: true, nightMode: nightMode()).fromUrl(doc.url,
                placeholder: (progress) => LoadingIndicator()),
      ),
    );
  }
}
