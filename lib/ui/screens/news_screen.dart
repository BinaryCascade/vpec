import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/loading_indicator.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen() : super();

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  static const String feedUrl = 'https://energocollege.ru/rss.xml';
  RssFeed? _feed;

  void updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch((url))) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
    }
  }

  Future<void> load() async {
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        return const RssFeed();
      }
      updateFeed(result);
    });
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(feedUrl));
      return RssFeed.parse(response.body);
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  bool isFeedEmpty() {
    return _feed == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isFeedEmpty() ?
             LoadingIndicator()
            : SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.5, vertical: 5.5),
                  child: ListView.builder(
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
                            item.description!.indexOf('alt=') - 2);
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () => openFeed(item.link!),
                            child: Column(
                              children: <Widget>[
                                AnimatedSize(
                                  curve: Curves.fastOutSlowIn,
                                  duration: const Duration(milliseconds: 400),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: CachedNetworkImage(
                                        imageUrl: imgUrl,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            SizedBox(
                                                height: 200,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Image.memory(
                                                    kTransparentImage)),
                                        errorWidget: (context, url, error) =>
                                            Container()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 13),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item.title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Row(
                                          children: <Widget>[
                                            const Spacer(),
                                            Text(
                                              DateFormat('d MMMM yyyy, HH:mm')
                                                  .format(_parseRfc822DateTime(
                                                      item.pubDate!)!),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            )
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
                    },
                  ),
                )));
  }
}

// our rss feed use rfc822 date format, so we need parse this
DateTime? _parseRfc822DateTime(String dateString) {
  const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';

  try {
    final num length = dateString.length.clamp(0, rfc822DatePattern.length);
    final trimmedPattern = rfc822DatePattern.substring(0,
        length as int);
    final format = DateFormat(trimmedPattern, 'en_US');
    return format.parse(dateString);
  } on FormatException {
    return null;
  }
}
