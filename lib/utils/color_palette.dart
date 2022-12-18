part of '../theme.dart';

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

extension ColorPaletteOnBuildContextExt on BuildContext {
  /// Get [ColorPalette] of [context]
  ColorPalette get palette => Theme.of(this).extension<ColorPalette>()!;
}
