import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_indicator.dart';
import 'news_logic.dart';
import 'news_ui.dart';

@immutable
class NewsScreenProvider extends StatelessWidget {
  const NewsScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsLogic(),
      child: const NewsScreen(),
    );
  }
}

@immutable
class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<NewsLogic>(
      builder: (context, state, child) {
        return FutureBuilder<RssFeed?>(
          future: state.loadFeed(),
          builder: (BuildContext context, AsyncSnapshot<RssFeed?> snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: NewsListView(feed: snapshot.data),
                  ));
            }
            return const LoadingIndicator();
          },
        );
      },
    ));
  }
}
