import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Can't launch url: $url";
  }
}

Future<void> shareFile(String? url) async {
  if (url != null) {
    // download file from given url
    HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);

    // get temp directory, write and share file
    final Directory tempDir = await getTemporaryDirectory();
    final File file =
        await File('${tempDir.path}/${url.split('/').last}').create();
    await file.writeAsBytes(bytes);

    if (response.statusCode != 404) {
      Share.shareFiles([file.path]);
    } else {
      await file.delete();
    }
  }
}

/// creating modal sheet with rounded corners
Future<void> roundedModalSheet(
    {required BuildContext context,
    required String title,
    bool isDismissible = true,
    bool enableDrag = true,
    required Widget child}) async {
  await showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: true,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
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
                  padding: const EdgeInsets.only(bottom: 15),
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
