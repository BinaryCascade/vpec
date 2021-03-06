import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

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

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
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
                    child: ListView.builder(
                      itemCount: _feed.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = _feed.items[index];
                        String imgUrl = item.description.substring(
                            item.description.indexOf("src=") + 5,
                            item.description.indexOf('alt=') - 2);
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => openFeed(item.link),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Image.network(
                                    imgUrl,
                                    frameBuilder: (BuildContext context,
                                            Widget child,
                                            int frame,
                                            bool wasSynchronouslyLoaded) =>
                                        wasSynchronouslyLoaded
                                            ? child
                                            : AnimatedOpacity(
                                                child: child,
                                                opacity: frame == null ? 0 : 1,
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve: Curves.easeOut,
                                              ),
                                    loadingBuilder:
                                        (context, child, progress) =>
                                            progress == null
                                                ? child
                                                : LinearProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Theme.of(context)
                                                                .accentColor),
                                                  ),
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
                                            Text(item.pubDate),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                onRefresh: () => load(),
              ));
  }
}
