import 'package:flutter/material.dart';

import '/utils/icons.dart';
import '/utils/utils.dart';
import '/widgets/styled_widgets.dart';
import '../../theme.dart';

class AboutDeveloperCard extends StatelessWidget {
  final String name, post, nickname;
  final String? vkUrl, tgUrl;

  const AboutDeveloperCard({
    Key? key,
    required this.name,
    required this.post,
    required this.nickname,
    this.vkUrl,
    this.tgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
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
                    nickname,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const Spacer(),
                  if (vkUrl != null)
                    IconButton(
                      tooltip: 'Открыть страницу в VK',
                      icon: Icon(
                        VpecIconPack.vk,
                        size: 32,
                        color: Theme.of(context)
                            .extension<ColorPalette>()!
                            .accentColor,
                      ),
                      onPressed: () => openUrl(vkUrl!),
                    ),
                  if (tgUrl != null)
                    IconButton(
                      tooltip: 'Открыть страницу в Telegram',
                      icon: Icon(
                        VpecIconPack.telegram,
                        size: 32,
                        color: Theme.of(context)
                            .extension<ColorPalette>()!
                            .accentColor,
                      ),
                      onPressed: () => openUrl(tgUrl!),
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
