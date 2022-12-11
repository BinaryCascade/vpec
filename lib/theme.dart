// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'widgets/md2_tab_indicator.dart';

const FontWeight thin = FontWeight.w100;
const FontWeight extraLight = FontWeight.w200;
const FontWeight light = FontWeight.w300;
const FontWeight regular = FontWeight.w400;
const FontWeight medium = FontWeight.w500;
const FontWeight semiBold = FontWeight.w600;
const FontWeight bold = FontWeight.w700;
const FontWeight extraBold = FontWeight.w800;
const FontWeight black = FontWeight.w900;

@immutable
class ColorPalette extends ThemeExtension<ColorPalette> {
  const ColorPalette({
    required this.accentColor,
    required this.highEmphasis,
    required this.mediumEmphasis,
    required this.lowEmphasis,
    required this.outsideBorderColor,
    required this.backgroundSurface,
    required this.levelOneSurface,
    required this.levelTwoSurface,
    required this.levelThreeSurface,
  });

  final Color accentColor;
  final Color highEmphasis;
  final Color mediumEmphasis;
  final Color lowEmphasis;
  final Color outsideBorderColor;
  final Color backgroundSurface;
  final Color levelOneSurface;
  final Color levelTwoSurface;
  final Color levelThreeSurface;

  @override
  ThemeExtension<ColorPalette> copyWith({
    Color? accentColor,
    Color? highEmphasis,
    Color? mediumEmphasis,
    Color? lowEmphasis,
    Color? outsideBorderColor,
    Color? backgroundSurface,
    Color? levelOneSurface,
    Color? levelTwoSurface,
    Color? levelThreeSurface,
  }) {
    return ColorPalette(
      accentColor: accentColor ?? this.accentColor,
      highEmphasis: highEmphasis ?? this.highEmphasis,
      mediumEmphasis: mediumEmphasis ?? this.mediumEmphasis,
      lowEmphasis: lowEmphasis ?? this.lowEmphasis,
      outsideBorderColor: outsideBorderColor ?? this.outsideBorderColor,
      backgroundSurface: backgroundSurface ?? this.backgroundSurface,
      levelOneSurface: levelOneSurface ?? this.levelOneSurface,
      levelTwoSurface: levelTwoSurface ?? this.levelTwoSurface,
      levelThreeSurface: levelThreeSurface ?? this.levelThreeSurface,
    );
  }

  @override
  ThemeExtension<ColorPalette> lerp(
    ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other is! ColorPalette) return this;

    return ColorPalette(
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      highEmphasis: Color.lerp(highEmphasis, other.highEmphasis, t)!,
      mediumEmphasis: Color.lerp(mediumEmphasis, other.mediumEmphasis, t)!,
      lowEmphasis: Color.lerp(lowEmphasis, other.lowEmphasis, t)!,
      outsideBorderColor:
          Color.lerp(outsideBorderColor, other.outsideBorderColor, t)!,
      backgroundSurface:
          Color.lerp(backgroundSurface, other.backgroundSurface, t)!,
      levelOneSurface: Color.lerp(levelOneSurface, other.levelOneSurface, t)!,
      levelTwoSurface: Color.lerp(levelTwoSurface, other.levelTwoSurface, t)!,
      levelThreeSurface:
          Color.lerp(levelThreeSurface, other.levelThreeSurface, t)!,
    );
  }
}

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
      backgroundColor: levelTwoSurface,
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
      backgroundColor: levelTwoSurface,
      foregroundColor: highEmphasis,
    ),
    cardTheme: const CardTheme(margin: EdgeInsets.zero),
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
        textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
        shape: const StadiumBorder(),
        primary: accentColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
        shape: const StadiumBorder(),
        side: const BorderSide(
          width: 1.5,
          color: accentColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
        shape: const StadiumBorder(),
        primary: accentColor,
        onPrimary: backgroundSurface,
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
      backgroundColor: levelTwoSurface,
      foregroundColor: accentColor,
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
      backgroundColor: levelTwoSurface,
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
      backgroundColor: levelTwoSurface,
      foregroundColor: highEmphasis,
    ),
    cardTheme: const CardTheme(margin: EdgeInsets.zero),
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
        textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
        shape: const StadiumBorder(),
        primary: accentColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
        shape: const StadiumBorder(),
        side: const BorderSide(
          width: 1.5,
          color: accentColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            const TextStyle(fontFamily: 'Montserrat', fontWeight: semiBold),
        shape: const StadiumBorder(),
        primary: accentColor,
        onPrimary: backgroundSurface,
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
      backgroundColor: levelTwoSurface,
      foregroundColor: accentColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: accentColor,
      unselectedItemColor: mediumEmphasis,
      backgroundColor: levelTwoSurface,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: levelOneSurface),
  );
}
