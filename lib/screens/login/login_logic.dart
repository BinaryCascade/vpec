import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '/screens/settings/settings_logic.dart';
import '/utils/hive_helper.dart';
import '../../models/document_model.dart';
import '../../utils/firebase_auth.dart';
import '../../utils/theme/theme.dart';
import '../../utils/theme_helper.dart';
import '../../utils/utils.dart';
import 'login_ui.dart';

class LoginLogic extends ChangeNotifier {
  static Future<void> openLogin(BuildContext context) async {
    FirebaseAnalytics.instance.logEvent(name: 'login_manual');
    await SettingsLogic.accountLogin(context);
    if (context.read<FirebaseAppAuth>().accountInfo.level !=
        AccountType.entrant) {
      continueToApp(context);
    }
  }

  static Future<void> openQrScanner(BuildContext context) async {
    FirebaseAnalytics.instance.logEvent(name: 'login_qr_dialog');
    if (await Permission.camera.isGranted) {
      Navigator.pushNamed(context, '/loginByScan');
    } else {
      showRoundedModalSheet(
        context: context,
        title: 'Вход с помощью QR кода',
        child: const CameraPermissionRequestUI(),
      );
    }
  }

  static Future<void> requestPermissionForScanner(BuildContext context) async {
    PermissionStatus requestResult = await Permission.camera.request();
    if (requestResult == PermissionStatus.granted) {
      Navigator.pushNamed(context, '/loginByScan');
    } else if (requestResult == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  static void continueToApp(BuildContext context) {
    Navigator.popAndPushNamed(context, '/');
    HiveHelper.saveValue(key: 'isUserEntrant', value: false);
  }

  static Future<void> showAccountHelperDialog(BuildContext context) async {
    FirebaseAnalytics.instance.logEvent(name: 'login_helper_dialog');

    String dialogText = 'Данные для входа предоставляются в колледже. '
        'Для быстрого входа в аккаунт можно просканировать QR код с плаката';
    ThemeHelper.colorSystemChrome(mode: ColoringMode.lightIcons);
    await showDialog(
      context: context,
      builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: ThemeHelper.overlayStyleHelper(
            Color.alphaBlend(Colors.black54, context.palette.backgroundSurface),
          ),
          child: AlertDialog(
            content: Text(dialogText),
            actions: [
              TextButton(
                child: const Text('Закрыть'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
    ThemeHelper.colorSystemChrome();
  }

  /// Return URL for document, which need to display for entrant
  static Future<String> getEntrantUrl() async {
    final DocumentSnapshot entrant = await FirebaseFirestore.instance
        .collection('entrant')
        .doc('main')
        .get();

    return entrant['url'];
  }

  static Future<void> openEntrantScreen(final BuildContext context) async {
    final String docURL = await getEntrantUrl();
    Navigator.pushNamed(
      context,
      '/view_document',
      arguments: DocumentModel(
        title: 'Для абитуриента',
        subtitle: '',
        url: docURL,
      ),
    );
  }
}
