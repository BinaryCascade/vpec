// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/md2_tab_indicator.dart';

part 'color_palette.dart';

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
  const accentColor = Color(0xFF133676);
  const highEmphasis = Color.fromRGBO(0, 0, 0, 0.87);
  const mediumEmphasis = Color.fromRGBO(0, 0, 0, 0.60);
  const lowEmphasis = Color.fromRGBO(0, 0, 0, 0.38);
  const outsideBorderColor = Color.fromRGBO(0, 0, 0, 0.12);
  const surfaceIncrement = Color.fromRGBO(255, 255, 255, 0.40);
  const backgroundSurface = Color(0xFFE8E8E8);
  final levelOneSurface = Color.alphaBlend(surfaceIncrement, backgroundSurface);
  final levelTwoSurface = Color.alphaBlend(surfaceIncrement, levelOneSurface);
  final levelThreeSurface = Color.alphaBlend(surfaceIncrement, levelTwoSurface);

  return ThemeData(
    extensions: [
      ColorPalette(
        accentColor: accentColor,
        highEmphasis: highEmphasis,
        mediumEmphasis: mediumEmphasis,
        lowEmphasis: lowEmphasis,
        outsideBorderColor: outsideBorderColor,
        backgroundSurface: backgroundSurface,
        levelOneSurface: levelOneSurface,
        levelTwoSurface: levelTwoSurface,
        levelThreeSurface: levelThreeSurface,
      ),
    ],
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      height: 65,
      indicatorColor: accentColor,
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
        fontSize: 12,
        color: accentColor,
        overflow: TextOverflow.ellipsis,
      )),
      iconTheme: MaterialStateProperty.resolveWith((states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? levelTwoSurface
                : highEmphasis,
          )),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: accentColor,
      unselectedLabelColor: mediumEmphasis,
      indicator: MD2TabIndicator(accentColor),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(
          color: outsideBorderColor,
          width: 1.0,
          strokeAlign: StrokeAlign.inside,
        ),
      ),
      backgroundColor: levelTwoSurface,
      foregroundColor: highEmphasis,
      systemOverlayStyle: const SystemUiOverlayStyle(),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: outsideBorderColor,
          width: 1.0,
          strokeAlign: StrokeAlign.inside,
        ),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: accentColor.withOpacity(0.5),
      selectionHandleColor: accentColor,
    ),
    primaryColor: levelTwoSurface,
    cardColor: levelOneSurface,
    splashColor: accentColor.withOpacity(0.2),
    highlightColor: accentColor.withOpacity(0.15),
    focusColor: accentColor.withOpacity(0.2),
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme(
      primary: accentColor,
      secondary: accentColor,
      surface: levelTwoSurface,
      background: accentColor,
      error: Colors.red,
      onPrimary: backgroundSurface,
      onSecondary: backgroundSurface,
      onSurface: highEmphasis,
      onBackground: highEmphasis,
      onError: backgroundSurface,
      brightness: Brightness.light,
    ),
    dialogBackgroundColor: levelOneSurface,
    textTheme: const TextTheme(
      subtitle1:
          TextStyle(fontSize: 15, color: mediumEmphasis, fontWeight: medium),
      bodyText1:
          TextStyle(color: highEmphasis, fontSize: 16, fontWeight: regular),
      headline3: TextStyle(
        //News Card Title
        color: highEmphasis,
        fontSize: 16,
        fontFamily: 'Montserrat',
        fontWeight: medium,
      ),
      headline4: TextStyle(
        //Alert Card Title
        color: highEmphasis,
        fontSize: 17,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
      headline5: TextStyle(
        //used in time schedule for any time
        color: highEmphasis,
        fontSize: 36,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
      headline6: TextStyle(
        //used in time schedule for any other
        color: highEmphasis,
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
    ),
    iconTheme: const IconThemeData(
      size: 24.0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold,
          fontSize: 15,
        ),
        shape: const StadiumBorder(),
        foregroundColor: accentColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold,
          fontSize: 15,
        ),
        shape: const StadiumBorder(),
        side: const BorderSide(
          width: 1.5,
          color: accentColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold,
          fontSize: 15,
        ),
        shape: const StadiumBorder(),
        backgroundColor: accentColor,
        foregroundColor: backgroundSurface,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      errorStyle: TextStyle(
        color: Colors.red,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
      helperStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
      labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
      hintStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    scaffoldBackgroundColor: backgroundSurface,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: levelThreeSurface,
      foregroundColor: accentColor,
      shape: const CircleBorder(side: BorderSide(color: outsideBorderColor)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumEmphasis,
      backgroundColor: levelTwoSurface,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: levelOneSurface),
  );
}

ThemeData darkThemeData() {
  //dark theme
  const accentColor = Color(0xFF7B9DDB);
  const highEmphasis = Color.fromRGBO(255, 255, 255, 0.87);
  const mediumEmphasis = Color.fromRGBO(255, 255, 255, 0.60);
  const lowEmphasis = Color.fromRGBO(255, 255, 255, 0.38);
  const outsideBorderColor = Color.fromRGBO(255, 255, 255, 0.05);
  const surfaceIncrement = Color.fromRGBO(255, 255, 255, 0.04);
  const backgroundSurface = Color(0xFF121212);
  final levelOneSurface = Color.alphaBlend(surfaceIncrement, backgroundSurface);
  final levelTwoSurface = Color.alphaBlend(surfaceIncrement, levelOneSurface);
  final levelThreeSurface = Color.alphaBlend(surfaceIncrement, levelTwoSurface);

  return ThemeData.dark().copyWith(
    extensions: [
      ColorPalette(
        accentColor: accentColor,
        highEmphasis: highEmphasis,
        mediumEmphasis: mediumEmphasis,
        lowEmphasis: lowEmphasis,
        outsideBorderColor: outsideBorderColor,
        backgroundSurface: backgroundSurface,
        levelOneSurface: levelOneSurface,
        levelTwoSurface: levelTwoSurface,
        levelThreeSurface: levelThreeSurface,
      ),
    ],
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      height: 65,
      indicatorColor: accentColor,
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
        fontSize: 12,
        color: accentColor,
        overflow: TextOverflow.ellipsis,
      )),
      iconTheme: MaterialStateProperty.resolveWith((states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? levelTwoSurface
                : highEmphasis,
          )),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: accentColor,
      unselectedLabelColor: mediumEmphasis,
      indicator: MD2TabIndicator(accentColor),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(
          color: outsideBorderColor,
          width: 1.0,
          strokeAlign: StrokeAlign.inside,
        ),
      ),
      backgroundColor: levelTwoSurface,
      foregroundColor: highEmphasis,
      systemOverlayStyle: const SystemUiOverlayStyle(),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: outsideBorderColor,
          width: 1.0,
          strokeAlign: StrokeAlign.inside,
        ),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    brightness: Brightness.dark,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: accentColor.withOpacity(0.5),
      selectionHandleColor: accentColor,
    ),
    primaryColor: levelTwoSurface,
    cardColor: levelOneSurface,
    splashColor: accentColor.withOpacity(0.2),
    highlightColor: accentColor.withOpacity(0.15),
    focusColor: accentColor.withOpacity(0.2),
    splashFactory: InkRipple.splashFactory,
    colorScheme: ColorScheme(
      primary: accentColor,
      secondary: accentColor,
      surface: levelTwoSurface,
      background: backgroundSurface,
      error: Colors.redAccent,
      onPrimary: backgroundSurface,
      onSecondary: backgroundSurface,
      onSurface: highEmphasis,
      onBackground: highEmphasis,
      onError: backgroundSurface,
      brightness: Brightness.dark,
    ),
    dialogBackgroundColor: levelOneSurface,
    textTheme: const TextTheme(
      subtitle1:
          TextStyle(fontSize: 15, color: mediumEmphasis, fontWeight: medium),
      bodyText1:
          TextStyle(color: highEmphasis, fontSize: 16, fontWeight: regular),
      headline3: TextStyle(
        //News Card Title
        color: highEmphasis,
        fontSize: 16,
        fontFamily: 'Montserrat',
        fontWeight: medium,
      ),
      headline4: TextStyle(
        //Alert Card Title
        color: highEmphasis,
        fontSize: 17,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
      headline5: TextStyle(
        //used in time schedule for any time
        color: highEmphasis,
        fontSize: 36,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
      headline6: TextStyle(
        //used in time schedule for any other
        color: highEmphasis,
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
    ),
    iconTheme: const IconThemeData(
      size: 24.0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold,
          fontSize: 15,
        ),
        shape: const StadiumBorder(),
        foregroundColor: accentColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold,
          fontSize: 15,
        ),
        shape: const StadiumBorder(),
        side: const BorderSide(
          width: 1.5,
          color: accentColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: semiBold,
          fontSize: 15,
        ),
        shape: const StadiumBorder(),
        backgroundColor: accentColor,
        foregroundColor: backgroundSurface,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      errorStyle: TextStyle(
        color: Colors.redAccent,
        fontFamily: 'Montserrat',
        fontWeight: semiBold,
      ),
      helperStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
      labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
      hintStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    scaffoldBackgroundColor: backgroundSurface,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: levelThreeSurface,
      foregroundColor: accentColor,
      shape: const CircleBorder(side: BorderSide(color: outsideBorderColor)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumEmphasis,
      backgroundColor: levelTwoSurface,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: levelOneSurface),
  );
}
