import 'package:flutter/material.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';
import 'package:vpec/utils/hive_helper.dart';

class LoginLogic extends ChangeNotifier {
  static Future<void> openLogin(BuildContext context) async {
    await SettingsLogic.accountLogin(context);
    switch (SettingsLogic.getAccountMode()) {
      case UserMode.admin:
        continueToApp(context);
        break;
      case UserMode.student:
        continueToApp(context);
        break;
      case UserMode.employee:
        continueToApp(context);
        break;
      case UserMode.teacher:
        continueToApp(context);
        break;
      case UserMode.entrant:
        // entrant can't login to account
        break;
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
              )
            ],
          );
        });
  }
}
