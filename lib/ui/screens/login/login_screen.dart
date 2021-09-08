import 'package:flutter/material.dart';
import 'package:vpec/ui/screens/login/login_logic.dart';
import 'package:vpec/utils/theme_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(12.0),
        child: Center(
          child: Wrap(
            runSpacing: 8,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text(
                'Добро пожаловать',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 24.0),
              ),
              Text(
                'Чтобы продолжить, войдите в аккаунт',
                style: Theme.of(context).textTheme.subtitle1!,
                textAlign: TextAlign.end,
              ),
              SizedBox(
                height: 42.0,
                width: double.infinity,
                child: OutlinedButton(
                  child: const Text('Войти в аккаунт'),
                  onPressed: () async => await LoginLogic.openLogin(context),
                ),
              ),
              /// Entrant mode is not fully complete
              // SizedBox(
              //   height: 42.0,
              //   width: double.infinity,
              //   child: OutlinedButton(
              //     child: const Text('Я абитуриент'),
              //     onPressed: () =>
              //         Navigator.popAndPushNamed(context, '/entrant'),
              //   ),
              // ),
              GestureDetector(
                onTap: () => LoginLogic.showAccountHelperDialog(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Где найти данные?',
                      style: Theme.of(context).textTheme.subtitle1!,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
