import 'package:flutter/material.dart';

import '/utils/icons.dart';
import '/widgets/styled_widgets.dart';
import '../../utils/theme/theme.dart';
import '../../widgets/system_bar_cover.dart';
import 'menu_logic.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: StatusBarCover(
        height: MediaQuery.of(context).padding.top,
      ),
      body: SingleChildScrollView(
        padding: MediaQuery.of(context).padding.add(const EdgeInsets.all(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // settings block
            StyledListTile(
              icon: Icon(
                Icons.settings_outlined,
                color: context.palette.accentColor,
                size: 32,
              ),
              title: 'Настройки',
              subtitle: 'Выбрать тему и стартовый экран',
              onTap: () async {
                await Navigator.pushNamed(context, '/settings');
              },
            ),
            // information block
            const Divider(),
            StyledListTile(
              icon: Icon(
                Icons.group_outlined,
                color: context.palette.accentColor,
                size: 32,
              ),
              title: 'Список преподавателей',
              subtitle: 'Их дисциплины, кабинеты',
              onTap: () async {
                await Navigator.pushNamed(context, '/teacher');
              },
            ),
            StyledListTile(
              icon: Icon(
                VpecIconPack.account_cog_outline,
                color: context.palette.accentColor,
                size: 32,
              ),
              title: 'Администрация колледжа',
              subtitle: 'По вопросам и предложениям',
              onTap: () async {
                await Navigator.pushNamed(context, '/administration');
              },
            ),
            FutureBuilder<bool>(
              future: MenuLogic.isOpenDoorsDay,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return StyledListTile(
                      icon: Icon(
                        Icons.rule_outlined,
                        color: context.palette.accentColor,
                        size: 32,
                      ),
                      title: 'Моя профессиональная направленность',
                      subtitle: 'Узнать свою предрасположенность',
                      onTap: () async {
                        await Navigator.pushNamed(context, '/job_quiz');
                      },
                    );
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
                color: context.palette.accentColor,
              ),
              onTap: () async {
                await Navigator.pushNamed(context, '/documents');
              },
            ),
          ],
        ),
      ),
    );
  }
}
