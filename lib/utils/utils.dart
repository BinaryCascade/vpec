import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/theme.dart';
import 'theme_helper.dart';

/// Open in browser given [url]
Future<void> openUrl(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
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

    if (response.statusCode == 200) {
      await Share.shareXFiles([XFile(file.path)]);
      await file.delete();
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
  ThemeHelper.colorSystemChrome(mode: ColoringMode.lightIcons);
  T? toReturn = await showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    isScrollControlled: true,
    enableDrag: enableDrag,
    backgroundColor: Colors.transparent,
    builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeHelper.overlayStyleHelper(
        Color.alphaBlend(Colors.black54, context.palette.backgroundSurface),
      ),
      child: customLayout ??
          Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 15,
              left: 15,
              right: 15,
            ),
            decoration: BoxDecoration(
              color: context.palette.levelTwoSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: context.palette.outsideBorderColor,
              ),
            ),
            margin: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: [
                    MediaQuery.of(context).viewInsets.bottom,
                    MediaQuery.of(context).viewPadding.bottom,
                  ].reduce(max) +
                  10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                isDismissible
                    ? Column(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 5,
                            child: DecoratedBox(
                              decoration: ShapeDecoration(
                                shape: const StadiumBorder(),
                                color: context.palette.lowEmphasis,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(height: 5),
                Center(
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
                const SizedBox(height: 15),
                child ??
                    ErrorWidget('You need implement [child] if you want '
                        'use styled layout, or [customLayout] if you need your '
                        'own layout'),
              ],
            ),
          ),
    ),
  );
  ThemeHelper.colorSystemChrome(mode: ColoringMode.byCurrentTheme);

  return toReturn;
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
