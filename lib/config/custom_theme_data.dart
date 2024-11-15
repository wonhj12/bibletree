import 'package:bibletree/config/palette.dart';
import 'package:flutter/material.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: Palette.subtitle,
        fontWeight: Palette.medium,
        color: Palette.primary,
      ),
      centerTitle: true,
      backgroundColor: Palette.green, // Appbar BG
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: Palette.green200,
      dialTextColor: Palette.primary,
      hourMinuteTextColor: Palette.primary,
      dayPeriodColor: Palette.green,
      dayPeriodTextColor: Palette.primary,
      dayPeriodBorderSide: BorderSide(color: Palette.green),
      dialBackgroundColor: Palette.green100,
      hourMinuteColor: Palette.green100,
    ),
    scaffoldBackgroundColor: Palette.green, // Scaffold BG
    colorScheme: const ColorScheme.light(
      primary: Palette.green,
      onPrimary: Palette.primary,
      secondary: Palette.green200,
      onSecondary: Palette.secondary,
      onTertiary: Palette.tertiary,
    ),
    highlightColor: Colors.transparent, // Modal highlight color
    splashColor: Palette.green400, // Modal splash color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Palette.primary),
    ),
  );

  static final ThemeData dark = ThemeData(
    fontFamily: 'Pretendard',
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: Palette.subtitle,
        fontWeight: Palette.medium,
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: Palette.brown,
    ),
    scaffoldBackgroundColor: Palette.brown,
    colorScheme: const ColorScheme.dark(
      primary: Palette.brown,
      onPrimary: Palette.white,
      secondary: Palette.brown300,
      onSecondary: Palette.tertiary,
      onTertiary: Palette.secondary,
    ),
    highlightColor: Colors.transparent,
    splashColor: Palette.brown400,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Palette.white),
    ),
  );
}
