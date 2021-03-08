import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen() : super();

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static const String FEED_URL = 'http://energocollege.ru/rss.xml';
  RssFeed _feed;
  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateFeed(feed) {
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
      return null;
    }
  }

  load() async {
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        return RssFeed();
      }
      updateFeed(result);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(FEED_URL));
      return RssFeed.parse(response.body);
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    load();
  }

  bool isFeedEmpty() {
    return _feed == null || _feed.items == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isFeedEmpty()
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                key: _refreshKey,
                child: SafeArea(
                    top: false,
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _feed.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = _feed.items[index];
                          String imgUrl = item.description.substring(
                              item.description.indexOf("src=") + 5,
                              item.description.indexOf('alt=') - 2);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () => openFeed(item.link),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: imgUrl,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Container(
                                                height: 200,
                                                child: Image.memory(
                                                    kTransparentImage)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            item.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 6),
                                            child: Row(
                                              children: <Widget>[
                                                Spacer(),
                                                Text(DateFormat(
                                                        'd MMM yyyy, HH:mm')
                                                    .format(item.pubDate)),
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
                    )),
                onRefresh: () => load(),
              ));
  }
}
