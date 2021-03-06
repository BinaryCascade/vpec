import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  final Widget child;

  const SplashScreen({Key key, this.child}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _loadingSettings();
    super.initState();
  }

  void _loadingSettings() {
    _initApp();
  }

  void _initApp() {}

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
