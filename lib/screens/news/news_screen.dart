import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/loading_indicator.dart';
import '../../widgets/system_bar_cover.dart';
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
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    loadFeed();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'news_screen');
    super.initState();
  }

  Future<void> loadFeed() async {
    await context.read<NewsLogic>().loadFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: StatusBarCover(
        height: MediaQuery.of(context).padding.top,
      ),
      body: Consumer<NewsLogic>(
        builder: (context, state, child) {
          if (state.rssFeed == null) return const LoadingIndicator();

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: NewsListView(feed: state.rssFeed),
            ),
          );
        },
      ),
    );
  }
}
