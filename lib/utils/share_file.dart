import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

Future<void> shareFile(String url) async {
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
