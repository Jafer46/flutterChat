import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE5E5E7),
  100: Color(0xFFBEBFC2),
  200: Color(0xFF92949A),
  300: Color(0xFF666971),
  400: Color(0xFF464852),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF21242F),
  700: Color(0xFF1B1E27),
  800: Color(0xFF161821),
  900: Color(0xFF0D0F15),
});
const int _primaryPrimaryValue = 0xFF252834;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFF5959),
  200: Color(_primaryAccentValue),
  400: Color(0xFFF20100),
  700: Color(0xFFD90700),
});
const int _primaryAccentValue = 0xFFFF2626;

class AppColor {
  static const primary = Color(_primaryPrimaryValue);
  static const primaAccent = Color(_primaryAccentValue);
}
