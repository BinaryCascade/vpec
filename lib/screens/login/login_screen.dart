import 'package:flutter/material.dart';

import '/utils/theme_helper.dart';
import 'login_logic.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    List<Widget> children = [
      Expanded(
        child: Image(
          width: 0.75 * MediaQuery.of(context).size.shortestSide,
          height: 0.75 * MediaQuery.of(context).size.shortestSide,
          image: AssetImage(ThemeHelper.isDarkMode
              ? 'assets/splash/dark.png'
              : 'assets/splash/light.png'),
        ),
      ),
      const SizedBox(width: 20, height: 20),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Добро пожаловать',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Чтобы продолжить, войдите в аккаунт',
                style: Theme.of(context).textTheme.subtitle1!,
                textAlign: TextAlign.end,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.end,
              runSpacing: 10,
              children: [
                SizedBox(
                  height: 42.0,
                  width: double.infinity,
                  child: OutlinedButton(
                    child: const Text('Войти в аккаунт'),
                    onPressed: () async => await LoginLogic.openLogin(context),
                  ),
                ),
                SizedBox(
                  height: 42.0,
                  width: double.infinity,
                  child: OutlinedButton(
                    child: const Text('Я абитуриент'),
                    onPressed: () async =>
                        await LoginLogic.openEntrantScreen(context),
                  ),
                ),
                GestureDetector(
                  onTap: () => LoginLogic.showAccountHelperDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Где найти данные?',
                      style: Theme.of(context).textTheme.subtitle1!,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(12.0),
        child: MediaQuery.of(context).size.aspectRatio > 1
            ? Row(children: children)
            : Column(children: children),
      ),
    );
  }
}
