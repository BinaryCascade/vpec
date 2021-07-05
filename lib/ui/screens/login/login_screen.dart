import 'package:flutter/material.dart';
import 'package:vpec/ui/screens/login/login_logic.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';
import 'package:vpec/utils/buttons.dart';
import 'package:vpec/utils/theme_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ВЭК — расписание, звонки и события',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
              child: StyledOutlinedButton(
                text: 'Войти в аккаунт',
                onPressed: () async => await LoginLogic.openLogin(context),
              ),
            ),
            StyledOutlinedButton(
              text: 'Я абитуриент',
              onPressed: () => Navigator.popAndPushNamed(context, '/entrant'),
            )
          ],
        ),
      ),
    );
  }
}
