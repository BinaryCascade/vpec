import 'package:flutter/material.dart';
import 'menu_ui.dart';
import '../../../ui/widgets/styled_widgets.dart';
import '../../../utils/icons.dart';
import '../../../utils/theme_helper.dart';

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
              styledListTile(
                  context: context,
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
              styledListTile(
                  context: context,
                  icon: Icon(Icons.layers_outlined,
                      color: Theme.of(context).accentColor, size: 32),
                  title: 'Список кабинетов',
                  subtitle: 'В виде карты',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/cabinets');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
              styledListTile(
                  context: context,
                  icon: Icon(Icons.group_outlined,
                      color: Theme.of(context).accentColor, size: 32),
                  title: 'Список преподавателей',
                  subtitle: 'Их имена, кабинеты',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/teacher');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
              styledListTile(
                  context: context,
                  icon: Icon(VEKiconPack.account_cog_outline,
                      color: Theme.of(context).accentColor, size: 32),
                  title: 'Администрация колледжа',
                  subtitle: 'Вопросы, проблемы и предложения',
                  onTap: () async {
                    await Navigator.pushNamed(context, '/administration');
                    ThemeHelper()
                        .colorStatusBar(context: context, haveAppbar: false);
                  }),
              // documents block
              Divider(),
              buildDocuments(context),
            ],
          ),
        ),
      ),
    );
  }
}
