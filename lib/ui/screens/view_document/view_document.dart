import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:vpec/utils/share_file.dart';

import '../../../models/document_model.dart';
import '../../../utils/hive_helper.dart';
import '../../../utils/theme_helper.dart';
import '../../widgets/loading_indicator.dart';

class DocumentViewScreen extends StatelessWidget {
  const DocumentViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DocumentModel doc =
        ModalRoute.of(context)!.settings.arguments as DocumentModel;
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);
    // we don't need weird nulls (can be null if user type url by himself)
    if (doc.url!.isEmpty || doc.url == null) {
      Navigator.popAndPushNamed(context, '/');
    }

    ColorFilter darkModeFilter() {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(doc.title ?? 'Просмотр документа'),
        actions: [
          IconButton(
              tooltip: 'Поделиться',
              onPressed: () => shareFile(doc.url!),
              icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: Center(
        child: ColorFiltered(
          colorFilter: darkModeFilter(),
          child: const PDF(swipeHorizontal: true).fromUrl(doc.url!,
              placeholder: (progress) => const LoadingIndicator()),
        ),
      ),
    );
  }
}
