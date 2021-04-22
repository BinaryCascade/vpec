import 'package:flutter/material.dart';

import '../../../ui/widgets/styled_widgets.dart';
import '../../../utils/icons.dart';
import 'about_app_logic.dart';

class AboutDeveloperCard extends StatelessWidget {
  final String? name, post, nickname, vkUrl, tgUrl;

  const AboutDeveloperCard(
      {Key? key, this.name, this.post, this.nickname, this.vkUrl, this.tgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            StyledListTile(title: name, subtitle: post),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 18.0),
              child: Row(
                children: [
                  Text(
                    nickname!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Spacer(),
                  if (vkUrl != null)
                    IconButton(
                      tooltip: 'Открыть страницу в VK',
                      icon: Icon(
                        VpecIconPack.vk,
                        size: 32,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () => AboutAppLogic().openUrl(vkUrl!),
                    ),
                  if (tgUrl != null)
                    IconButton(
                      tooltip: 'Открыть страницу в Telegram',
                      icon: Icon(
                        VpecIconPack.telegram,
                        size: 32,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () => AboutAppLogic().openUrl(tgUrl!),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
