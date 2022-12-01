import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/settings/settings_logic.dart';
import '/utils/hive_helper.dart';
import '../../models/document_model.dart';
import '../../utils/firebase_auth.dart';

class LoginLogic extends ChangeNotifier {
  static Future<void> openLogin(BuildContext context) async {
    await SettingsLogic.accountLogin(context);
    if (context.read<FirebaseAppAuth>().accountInfo.level !=
        AccountType.entrant) {
      continueToApp(context);
    }
  }

  static void continueToApp(BuildContext context) {
    Navigator.popAndPushNamed(context, '/');
    HiveHelper.saveValue(key: 'isUserEntrant', value: false);
  }

  static void showAccountHelperDialog(BuildContext context) {
    String dialogText = 'Данные для входа предоставляются в колледже. '
        'Для быстрого входа в аккаунт можно просканировать QR код с плаката';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(dialogText),
          actions: [
            TextButton(
              child: const Text('Закрыть'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
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
