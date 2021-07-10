import 'package:flutter/material.dart';

const FontWeight thin = FontWeight.w100;
const FontWeight extraLight = FontWeight.w200;
const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

ThemeData themeData() {
  //light theme
  const backgroundColor = Color(0xFFE8E8E8);
  const firstLevelColor = Color(0xFFF5F5F5);
  const secondLevelColor = Color(0xFFFFFFFF);
  const accentColor = Color(0xFF133676);
  const highContrast = Colors.black87;
  const mediumContrast = Color(0x99000000);
  const lowContrast = Colors.black38;

  return ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor.withOpacity(0.5),
        selectionHandleColor: accentColor),
    primaryColor: secondLevelColor,
    cardColor: firstLevelColor,
    splashColor: accentColor.withOpacity(0.2),
    colorScheme: const ColorScheme(
        primary: accentColor,
        primaryVariant: accentColor,
        secondary: accentColor,
        secondaryVariant: accentColor,
        surface: secondLevelColor,
        background: accentColor,
        error: Colors.red,
        onPrimary: Color(0xDEFFFFFF),
        onSecondary: backgroundColor,
        onSurface: highContrast,
        onBackground: highContrast,
        onError: Color(0xDEFFFFFF),
        brightness: Brightness.light),
    dialogBackgroundColor: firstLevelColor,
    textTheme: const TextTheme(
        subtitle1:
            TextStyle(fontSize: 15, color: mediumContrast, fontWeight: medium),
        bodyText1:
            TextStyle(color: highContrast, fontSize: 17, fontWeight: regular),
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
            fontFamily: 'Montserrat',
            fontWeight: semiBold),
        headline6: TextStyle(
            //used in time schedule for any other
            color: highContrast,
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: semiBold)),
    iconTheme: const IconThemeData().copyWith(
      size: 20.0,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle:
          const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
          shape: const StadiumBorder(),
          primary: accentColor,
        )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
            shape: const StadiumBorder(),
            side: const BorderSide(
              width: 1.5,
              color: accentColor,
            ))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle:
          const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
          shape: const StadiumBorder(),
          primary: accentColor,
          onPrimary: backgroundColor,
        )),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      errorStyle: TextStyle(
          color: Colors.red,
          fontFamily: 'Montserrat',
          fontWeight: semiBold),
      labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold),
      hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
    scaffoldBackgroundColor: backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondLevelColor,
      foregroundColor: accentColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumContrast,
      backgroundColor: secondLevelColor,
    ),
  );
}

ThemeData darkThemeData() {
  //dark theme
  const backgroundColor = Color(0xFF121212);
  const firstLevelColor = Color(0xFF1F1F1F);
  const secondLevelColor = Color(0xFF292929);
  const accentColor = Color(0xFF7B9DDB);
  const highContrast = Color(0xDEFFFFFF);
  const mediumContrast = Colors.white60;
  const lowContrast = Color(0x61FFFFFF);

  return ThemeData.dark().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    brightness: Brightness.dark,
    textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor.withOpacity(0.5),
        selectionHandleColor: accentColor),
    primaryColor: secondLevelColor,
    cardColor: firstLevelColor,
    splashColor: accentColor.withOpacity(0.2),
    colorScheme: const ColorScheme(
        primary: accentColor,
        primaryVariant: accentColor,
        secondary: accentColor,
        secondaryVariant: accentColor,
        surface: secondLevelColor,
        background: backgroundColor,
        error: Colors.redAccent,
        onPrimary: highContrast,
        onSecondary: backgroundColor,
        onSurface: highContrast,
        onBackground: highContrast,
        onError: highContrast,
        brightness: Brightness.dark),
    dialogBackgroundColor: firstLevelColor,
    textTheme: const TextTheme(
        subtitle1:
            TextStyle(fontSize: 15, color: mediumContrast, fontWeight: medium),
        bodyText1:
            TextStyle(color: highContrast, fontSize: 17, fontWeight: regular),
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
            fontFamily: 'Montserrat',
            fontWeight: semiBold),
        headline6: TextStyle(
            //used in time schedule for any other
            color: highContrast,
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: semiBold)),
    iconTheme: const IconThemeData().copyWith(
      size: 20.0,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle:
          const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
          shape: const StadiumBorder(),
          primary: accentColor,
        )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
            shape: const StadiumBorder(),
            side: const BorderSide(
              width: 1.5,
              color: accentColor,
            ))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle:
          const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
          shape: const StadiumBorder(),
          primary: accentColor,
          onPrimary: backgroundColor,
        )),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      errorStyle: TextStyle(
          color: Colors.redAccent,
          fontFamily: 'Montserrat',
          fontWeight: semiBold),
      labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold),
      hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
    scaffoldBackgroundColor: backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondLevelColor,
      foregroundColor: accentColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumContrast,
      backgroundColor: secondLevelColor,
    ),
  );
}
