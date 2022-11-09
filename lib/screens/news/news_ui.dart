import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

import '/utils/utils.dart';
import 'news_logic.dart';

@immutable
class NewsListView extends StatelessWidget {
  const NewsListView({
    Key? key,
    required RssFeed? feed,
  })  : _feed = feed,
        super(key: key);

  final RssFeed? _feed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _feed!.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed!.items[index];
        String imgUrl = '';
        if (item.description!.contains('src=') &&
            item.description!.contains('alt=')) {
          imgUrl = item.description!.substring(
            item.description!.indexOf("src=") + 5,
            item.description!.indexOf('alt=') - 2,
          );
        }

        return NewsItemCard(item: item, imgUrl: imgUrl);
      },
    );
  }
}

@immutable
class NewsItemCard extends StatelessWidget {
  const NewsItemCard({
    Key? key,
    required this.item,
    required this.imgUrl,
  }) : super(key: key);

  final RssItem item;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => openUrl(item.link!),
          child: Column(
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.memory(kTransparentImage),
                    ),
                    errorWidget: (context, url, error) => Container(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title!,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: <Widget>[
                          const Spacer(),
                          Text(
                            DateFormat('d MMMM yyyy, HH:mm').format(
                              NewsLogic.parseRfc822DateTime(item.pubDate!)!,
                            ),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
