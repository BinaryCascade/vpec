import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Open in browser given [url]
Future<void> openUrl(String url) async {
  Uri _uri = Uri.parse(url);
  if (await canLaunchUrl(_uri)) {
    await launchUrl(
      _uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw "Can't launch url: $url";
  }
}

/// Share any file from given [url].
///
/// If [url] is null, then nothing will do
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

/// Show modal sheet with rounded corners.
///
/// Use [child] with [title] if you want use styled layout.
///
/// Or use [customLayout] if you need something other.
//ignore: long-parameter-list
Future<T?> showRoundedModalSheet<T>({
  required BuildContext context,
  String? title,
  bool isDismissible = true,
  bool enableDrag = true,
  Widget? child,
  Widget? customLayout,
}) async {
  return showModalBottomSheet<T>(
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
    builder: (context) =>
        customLayout ??
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Center(
                  child: title != null
                      ? Text(
                          title,
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        )
                      : ErrorWidget('You need implement [title] if you want '
                          'use styled layout, or [customLayout] if you need'
                          ' your own layout'),
                ),
              ),
              child ??
                  ErrorWidget('You need implement [child] if you want '
                      'use styled layout, or [customLayout] if you need your '
                      'own layout'),
            ],
          ),
        ),
  );
}

class LowAndroidHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// On Android 7.0 and lower bug:
///
/// `CERTIFICATE_VERIFY_FAILED: certificate has expired`
///
/// This method fix it.
Future<void> useHttpOverrides() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt <= 24) {
      HttpOverrides.global = LowAndroidHttpOverrides();
    }
  }
}
