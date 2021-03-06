import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) {
  //light theme
  return ThemeData(
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: Color(0xFF777777),
        selectionHandleColor: Color(0xFF000000)),
    primaryColor: Colors.white,
    accentColor: Color(0xFF133676),
    backgroundColor: Colors.white,
    textTheme: TextTheme(
        subtitle1: TextStyle(fontSize: 15, color: Color(0xFF666666)),
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),
        headline3: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: "Montserrat-Regular",
            fontWeight: FontWeight.bold),
        headline4: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: "Montserrat-Regular",
            fontWeight: FontWeight.bold),
        headline5: TextStyle(
          //used in time schedule for time
            color: Colors.black,
            fontSize: 36,
            fontFamily: "Montserrat"),
        headline6: TextStyle(
          //used in time schedule for any other
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Montserrat")),
    iconTheme: Theme.of(context).iconTheme.copyWith(size: 20.0),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(
                Theme.of(context).accentColor.withOpacity(0.20)))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 1,
              color: Theme.of(context).accentColor,
            ))),
  );
}

ThemeData darkThemeData(BuildContext context) {
  //dark theme
  return ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Color(0xFF777777),
      selectionHandleColor: Color(0xFFFFFFFF),
    ),
    primaryColor: Color(0xFF222222),
    accentColor: Color(0xFF7B9DDB),
    textTheme: TextTheme(
        subtitle1: TextStyle(fontSize: 15, color: Color(0xFFbbbbbb)),
        bodyText1: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
        headline3: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Montserrat-Regular",
            fontWeight: FontWeight.bold),
        headline4: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Montserrat-SemiBold"),
        headline5: TextStyle(
          //used in time schedule for any time
            color: Colors.white,
            fontSize: 36,
            fontFamily: "Montserrat"),
        headline6: TextStyle(
          //used in time schedule for any other
            color: Colors.white,
            fontSize: 18,
            fontFamily: "Montserrat")),
    iconTheme: Theme.of(context).iconTheme.copyWith(size: 20.0),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(
                Theme.of(context).accentColor.withOpacity(0.20)))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
              width: 1,
              color: Theme.of(context).accentColor,
            ))),
  );
}
