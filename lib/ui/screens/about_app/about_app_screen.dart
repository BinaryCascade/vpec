import 'package:flutter/material.dart';

import '../../widgets/styled_widgets.dart';
import 'about_app_logic.dart';
import 'about_app_ui.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
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
                subtitle: 'Нажмите, чтобы открыть Github',
                onTap: () => AboutAppLogic().openUrl('https://github.com/'
                    'Volgograd-Power-Engineering-College/vpec')),
            StyledListTile(
                title: 'Лицензии библиотек',
                subtitle: 'Нажмите, чтобы открыть список лицензий',
                onTap: () => showLicensePage(
                    context: context,
                    applicationName: 'ВЭК',
                    applicationLegalese: 'Создано для студентов и работников '
                        'Волгоградского энергетического колледжа')),
          ],
        ),
      ),
    );
  }
}
