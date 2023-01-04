import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '/utils/utils.dart';
import '/widgets/styled_widgets.dart';
import 'about_app_ui.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Wrap(
          children: [
            StyledListTile(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Theme.of(context).colorScheme.error,
                size: 32,
              ),
              title: 'Разработано студентами колледжа',
              subtitle: 'в рамках дипломного проекта',
            ),
            const AboutDeveloperCard(
              nickname: 'Tembeon',
              name: 'Рафиков Артур',
              post: 'Старший разработчик',
              vkUrl: 'https://vk.com/id504890843',
              tgUrl: 'https://t.me/tembeon',
            ),
            const AboutDeveloperCard(
              nickname: 'Lazurit11',
              name: 'Гордеев Владислав',
              post: 'Младший разработчик, UI/UX дизайнер',
              vkUrl: 'https://vk.com/id187849966',
              tgUrl: 'https://t.me/lazurit11',
            ),
            const Divider(),
            StyledListTile(
              title: 'Исходный код приложения',
              subtitle: 'Нажмите, чтобы открыть GitHub',
              onTap: () {
                FirebaseAnalytics.instance.logEvent(name: 'developer_group_opened');

                openUrl('https://github.com/ShyroTeam/vpec');
              },
            ),
            StyledListTile(
              title: 'Лицензии библиотек',
              subtitle: 'Нажмите, чтобы открыть список лицензий',
              onTap: () {
                FirebaseAnalytics.instance.logEvent(name: 'developer_licenses_opened');

                showLicensePage(
                  context: context,
                  applicationName: 'ВЭК',
                  applicationLegalese: 'Создано для студентов и работников '
                      'Волгоградского энергетического колледжа',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
