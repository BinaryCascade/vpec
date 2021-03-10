import 'package:flutter/material.dart';

const thin = FontWeight.w100;
const extraLight = FontWeight.w200;
const light = FontWeight.w300;
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semiBold = FontWeight.w600;
const bold = FontWeight.w700;
const extraBold = FontWeight.w800;
const black = FontWeight.w900;

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
        selectionColor: accentColor.withOpacity(0.5),
        selectionHandleColor: accentColor),
    primaryColor: secondLevelColor,
    accentColor: accentColor,
    cardColor: firstLevelColor,
    textTheme: TextTheme(
        subtitle1:
            TextStyle(fontSize: 15, color: mediumContrast, fontWeight: medium),
        bodyText1:
            TextStyle(color: highContrast, fontSize: 15, fontWeight: regular),
        headline3: TextStyle(
            //News Card Title
            color: highContrast,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: medium),
        headline4: TextStyle(
            //Alert Card Title
            color: highContrast,
            fontSize: 17,
            fontFamily: 'Montserrat',
            fontWeight: semiBold),
        headline5: TextStyle(
            //used in time schedule for any time
            color: highContrast,
            fontSize: 36,
            fontFamily: 'Montserrat'),
        headline6: TextStyle(
            //used in time schedule for any other
            color: highContrast,
            fontSize: 18,
            fontFamily: 'Montserrat')),
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondLevelColor,
      foregroundColor: accentColor,
    ),
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
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor.withOpacity(0.5),
        selectionHandleColor: accentColor),
    primaryColor: secondLevelColor,
    accentColor: accentColor,
    cardColor: firstLevelColor,
    textTheme: TextTheme(
        subtitle1: TextStyle(
            fontSize: 15,
            color: mediumContrast,
            fontWeight: medium),
        bodyText1: TextStyle(
            color: highContrast,
            fontSize: 15,
            fontWeight: regular),
        headline3: TextStyle(
            //News Card Title
            color: highContrast,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: medium),
        headline4: TextStyle(
            //Alert Card Title
            color: highContrast,
            fontSize: 17,
            fontFamily: 'Montserrat',
            fontWeight: semiBold),
        headline5: TextStyle(
            //used in time schedule for any time
            color: highContrast,
            fontSize: 36,
            fontFamily: 'Montserrat'),
        headline6: TextStyle(
            //used in time schedule for any other
            color: highContrast,
            fontSize: 18,
            fontFamily: 'Montserrat')),
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: secondLevelColor,
      foregroundColor: accentColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumContrast,
      backgroundColor: secondLevelColor,
    ),
  );
}
