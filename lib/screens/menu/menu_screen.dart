import 'package:flutter/material.dart';

import '/utils/icons.dart';
import '/utils/theme_helper.dart';
import '/widgets/styled_widgets.dart';
import 'menu_logic.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).padding.add(const EdgeInsets.all(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // settings block
              StyledListTile(
                  icon: Icon(Icons.settings_outlined,
                      color: Theme.of(context).colorScheme.secondary, size: 32),
                  title: 'Настройки',
                  subtitle: 'Выбрать тему и стартовый экран',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/settings');
                    ThemeHelper.colorStatusBar(
                        context: context, haveAppbar: false);
                  }),
              // information block
              const Divider(),
              StyledListTile(
                  icon: Icon(Icons.layers_outlined,
                      color: Theme.of(context).colorScheme.secondary, size: 32),
                  title: 'Карта колледжа',
                  subtitle: 'Не знаете, где столовая?',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/cabinets');
                    ThemeHelper.colorStatusBar(
                        context: context, haveAppbar: false);
                  }),
              StyledListTile(
                  icon: Icon(Icons.group_outlined,
                      color: Theme.of(context).colorScheme.secondary, size: 32),
                  title: 'Список преподавателей',
                  subtitle: 'Их дисциплины, кабинеты',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/teacher');
                    ThemeHelper.colorStatusBar(
                        context: context, haveAppbar: false);
                  }),
              StyledListTile(
                  icon: Icon(VpecIconPack.account_cog_outline,
                      color: Theme.of(context).colorScheme.secondary, size: 32),
                  title: 'Администрация колледжа',
                  subtitle: 'По вопросам и предложениям',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/administration');
                    ThemeHelper.colorStatusBar(
                        context: context, haveAppbar: false);
                  }),
              FutureBuilder<bool>(
                future: MenuLogic.isOpenDoorsDay,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!) {
                      return StyledListTile(
                          icon: Icon(Icons.rule_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 32),
                          title: 'Моя профессиональная направленность',
                          subtitle: 'Узнать свою предрасположенность',
                          onTap: () async {
                            await Navigator.pushNamed(context, '/job_quiz');
                            ThemeHelper.colorStatusBar(
                                context: context, haveAppbar: false);
                          });
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
              // documents block
              const Divider(),
              StyledListTile(
                  title: 'Документы',
                  subtitle: 'Список документов',
                  icon: Icon(
                    Icons.description_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/documents');
                    ThemeHelper.colorStatusBar(
                        context: context, haveAppbar: false);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
