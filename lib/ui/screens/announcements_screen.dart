import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatefulWidget {
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Объявления')),
      body: Center(
        child: Text('Объявления'),
      ),
    );
  }
}
