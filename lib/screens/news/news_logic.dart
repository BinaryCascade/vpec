import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsLogic extends ChangeNotifier {
  static const String feedUrl = 'https://energocollege.ru/rss.xml';
  RssFeed? rssFeed;

  bool get isFeedNotEmpty {
    return rssFeed != null;
  }

  void updateFeed(feed) {
    rssFeed = feed;
    notifyListeners();
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client
          .get(Uri.parse(feedUrl))
          .timeout(const Duration(seconds: 70));
      updateFeed(RssFeed.parse(response.body));
      return RssFeed.parse(response.body);
    } catch (e) {
      return null;
    }
  }

  // this rss feed use rfc822 date format, so this is a parser for this format
  static DateTime? parseRfc822DateTime(String dateString) {
    const rfc822DatePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';

    try {
      final num length = dateString.length.clamp(0, rfc822DatePattern.length);
      final trimmedPattern = rfc822DatePattern.substring(0, length as int);
      final format = DateFormat(trimmedPattern, 'en_US');
      return format.parse(dateString);
    } on FormatException {
      return null;
    }
  }
}
