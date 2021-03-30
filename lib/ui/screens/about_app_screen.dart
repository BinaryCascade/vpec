import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ui/widgets/styled_widgets.dart';
import '../../utils/icons.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О приложении'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            aboutDeveloper(
              nickname: 'Tembeon',
              name: 'Рафиков Артур',
              post: 'Старший разработчик',
              vkUrl: 'https://vk.com/id504890843',
              tgUrl: 'https://t.me/tembeon',
            ),
            aboutDeveloper(
              nickname: 'Lazurit11',
              name: 'Гордеев Владислав',
              post: 'Младший разработчик, UI/UX дизайнер',
              vkUrl: 'https://vk.com/id187849966',
              tgUrl: 'https://t.me/lazurit11',
            ),
            Divider(),
            styledListTile(
                context: context,
                title: 'Исходный код приложения',
                subtitle: 'Нажмите, чтобы открыть Github',
                onTap: () => openUrl('https://github.com/'
                    'Volgograd-Power-Engineering-College/vpec')),
            styledListTile(
                context: context,
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

  Widget aboutDeveloper(
      {String name, String post, String nickname, String vkUrl, String tgUrl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            styledListTile(context: context, title: name, subtitle: post),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 18.0),
              child: Row(
                children: [
                  Text(
                    nickname,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Spacer(),
                  if (vkUrl != null)
                    IconButton(
                      tooltip: 'Открыть страницу в VK',
                      icon: Icon(
                        VEKiconPack.vk,
                        size: 32,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () => openUrl(vkUrl),
                    ),
                  if (tgUrl != null)
                    IconButton(
                      tooltip: 'Открыть страницу в Telegram',
                      icon: Icon(
                        VEKiconPack.telegram,
                        size: 32,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () => openUrl(tgUrl),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ошибка при открытии ссылки')));
    }
  }
}
