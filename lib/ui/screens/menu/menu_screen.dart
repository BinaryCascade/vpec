import 'package:flutter/material.dart';

import '../../../ui/widgets/styled_widgets.dart';
import '../../../utils/icons.dart';
import '../../../utils/theme_helper.dart';
import 'menu_logic.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // settings block
              StyledListTile(
                  icon: Icon(Icons.settings_outlined,
                      color: Theme.of(context).accentColor, size: 32),
                  title: 'Настройки',
                  subtitle: 'Изменить имя, тему, стартовый экран',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/settings');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
              // information block
              Divider(),
              // This fragment is done, but we have no maps in our server, that's why we comment this
              StyledListTile(
                  icon: Icon(Icons.layers_outlined,
                      color: Theme.of(context).accentColor, size: 32),
                  title: 'Список кабинетов',
                  subtitle: 'В виде карты',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/cabinets');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
              StyledListTile(
                  icon: Icon(Icons.group_outlined,
                      color: Theme.of(context).accentColor, size: 32),
                  title: 'Список преподавателей',
                  subtitle: 'Их имена, кабинеты',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/teacher');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
              StyledListTile(
                  icon: Icon(VpecIconPack.account_cog_outline,
                      color: Theme.of(context).accentColor, size: 32),
                  title: 'Администрация колледжа',
                  subtitle: 'Вопросы, проблемы и предложения',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/administration');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
              FutureBuilder<bool>(
                future: MenuLogic().isOpenDoorsDay,
                initialData: false,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data)
                      return StyledListTile(
                          icon: Icon(Icons.rule_outlined,
                              color: Theme.of(context).accentColor, size: 32),
                          title: 'Моя профессиональная направленность',
                          subtitle: 'Узнать свою предрасположенность',
                          onTap: () async {
                            await Navigator.pushNamed(context, '/job_quiz');
                            ThemeHelper().colorStatusBar(
                                context: context, haveAppbar: false);
                          });
                  }
                  return Container();
                },
              ),
              // documents block
              Divider(),
              StyledListTile(
                  title: 'Документы',
                  subtitle: 'Список документов',
                  icon: Icon(
                    Icons.description_outlined,
                    size: 32,
                    color: Theme.of(context).accentColor,
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/documents');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
