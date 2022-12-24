import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '/utils/theme_helper.dart';
import '../../utils/theme/theme.dart';
import '../../widgets/system_bar_cover.dart';
import 'login_logic.dart';
import 'login_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorSystemChrome();

    List<Widget> children = [
      Expanded(
        flex: 4,
        child: Image(
          width: 0.75 * MediaQuery.of(context).size.shortestSide,
          height: 0.75 * MediaQuery.of(context).size.shortestSide,
          image: AssetImage(
            ThemeHelper.isDarkMode
                ? 'assets/splash/dark.png'
                : 'assets/splash/light.png',
          ),
        ),
      ),
      const SizedBox(width: 20, height: 20),
      Expanded(
        flex: 3,
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
              padding: const EdgeInsets.only(top: 10, bottom: 25),
              child: Text(
                'Чтобы продолжить, выберите один из вариантов',
                style: Theme.of(context).textTheme.subtitle1!,
                textAlign: TextAlign.end,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.end,
              runSpacing: 10,
              children: [
                SizedBox(
                  height: 54.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.qr_code, size: 28),
                        SizedBox(width: 8),
                        Text(
                          'Войти в аккаунт',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    onPressed: () => LoginLogic.openQrScanner(context),
                  ),
                ),
                const SizedBox(
                  height: 46.0,
                  width: double.infinity,
                  child: EntrantButton(),
                ),
                GestureDetector(
                  onTap: () => LoginLogic.showAccountHelperDialog(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Где найти данные для входа?',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: context.palette.lowEmphasis,
                  ),
                  tooltip: 'Открыть системные настройки',
                  onPressed: () => openAppSettings(),
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: StatusBarCover(
        height: MediaQuery.of(context).padding.top,
      ),
      extendBody: true,
      bottomNavigationBar: SystemNavBarCover(
        height: MediaQuery.of(context).padding.bottom,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12.0),
        child: MediaQuery.of(context).size.aspectRatio > 1
            ? Row(children: children)
            : Column(children: children),
      ),
    );
  }
}
