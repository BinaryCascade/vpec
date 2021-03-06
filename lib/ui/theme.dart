import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) {
  //light theme
  const backgroundColor = Color(0xFFE8E8E8);
  const firstLevelColor = Color(0xFFF5F5F5);
  const secondLevelColor = Color(0xFFFFFFFF);
  const accentColor = Color(0xFF133676);
  const highContrast = Colors.black87;
  const mediumContrast = Color(0x99000000);
  const lowContrast = Colors.black38;

  return ThemeData(
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: Color(0xFF777777),
        selectionHandleColor: Color(0xFF000000)),
    primaryColor: secondLevelColor,
    accentColor: accentColor,
    cardColor: firstLevelColor,
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
    scaffoldBackgroundColor: backgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumContrast,
      backgroundColor: secondLevelColor,
    ),

  );
}

ThemeData darkThemeData(BuildContext context) {
  //dark theme
  const backgroundColor = Color(0xFF121212);
  const firstLevelColor = Color(0xFF1F1F1F);
  const secondLevelColor = Color(0xFF292929);
  const accentColor = Color(0xFF7B9DDB);
  const highContrast = Color(0xDEFFFFFF);
  const mediumContrast = Colors.white60;
  const lowContrast = Color(0x61FFFFFF);

  return ThemeData.dark().copyWith(
  brightness: Brightness.dark,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Color(0xFF777777),
      selectionHandleColor: highContrast,
    ),
    primaryColor: secondLevelColor,
    accentColor: accentColor,
    cardColor: firstLevelColor,
    textTheme: TextTheme(
        subtitle1: TextStyle(fontSize: 15, color: highContrast),
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
              color: accentColor,
            ))),
    scaffoldBackgroundColor: backgroundColor,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumContrast,
      backgroundColor: secondLevelColor,
    ),
  );
}
