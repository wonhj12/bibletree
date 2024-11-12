import "package:flutter/widgets.dart";

class Palette {
  // Basic colors
  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color.fromARGB(255, 100, 100, 100);
  static const Color tertiary = Color.fromARGB(255, 210, 210, 210);
  static const Color white = Color(0xFFFFFFFF);

  // App colors
  // Brown
  static const Color brown = Color(0xFF734a3c);
  static const Color brown400 = Color(0xFF8F6E63);
  static const Color brown300 = Color(0xFFAB928A);
  static const Color brown200 = Color(0xFFC7B7B1);
  static const Color brown100 = Color(0xFFE3DBD8);
  // LightBrown
  static const Color lightBrown = Color(0xFFD0B291);
  static const Color lightBrown400 = Color(0xFFD9C1A7);
  static const Color lightBrown300 = Color(0xFFE3D1BD);
  static const Color lightBrown200 = Color(0xFFECE0D3);
  static const Color lightBrown100 = Color(0xFFF6F0E9);
  // Green
  static const Color green = Color(0xFFD1D68a);
  static const Color green400 = Color(0xFFDADEA1);
  static const Color green300 = Color(0xFFE3E6B9);
  static const Color green200 = Color(0xFFEDEFD0);
  static const Color green100 = Color(0xFFF6F7E8);

  // Font sizes
  static const double largeTitle = 34;
  static const double title = 22;
  static const double subtitle = 20;
  static const double body = 17;
  static const double subheadline = 15;
  static const double footnote = 13;

  // Font weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400; // o
  static const FontWeight medium = FontWeight.w500; // o
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}
