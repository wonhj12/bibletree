import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

class CustomThemeData {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: AppStatics.body,
        fontWeight: AppStatics.medium,
        color: AppStatics.primary,
      ),
      centerTitle: true,
      backgroundColor: AppStatics.green, // Appbar BG
    ),
    scaffoldBackgroundColor: AppStatics.green, // Scaffold BG
    colorScheme: const ColorScheme.light(
      primary: AppStatics.green,
      onPrimary: AppStatics.primary,
      secondary: AppStatics.green200,
      onSecondary: AppStatics.secondary,
      onTertiary: AppStatics.tertiary,
    ),
    highlightColor: Colors.transparent, // Modal highlight color
    splashColor: AppStatics.green400, // Modal splash color
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppStatics.primary),
    ),
  );

  static final ThemeData dark = ThemeData(
    fontFamily: 'Pretendard',
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: AppStatics.body,
        fontWeight: AppStatics.medium,
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: AppStatics.brown,
    ),
    scaffoldBackgroundColor: AppStatics.brown,
    colorScheme: const ColorScheme.dark(
      primary: AppStatics.brown,
      onPrimary: AppStatics.white,
      secondary: AppStatics.brown300,
      onSecondary: AppStatics.tertiary,
      onTertiary: AppStatics.secondary,
    ),
    highlightColor: Colors.transparent,
    splashColor: AppStatics.brown400,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppStatics.white),
    ),
  );
}
