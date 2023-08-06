import 'package:flutter/material.dart';

const Color foregroundColor = Color(0xff9D1DF2);
const Color backgroundColor = Color(0xffDAD0E1);
const Color darkColor = Color(0xff300759);
const Color kDavysGrey = Color(0xFFE5B6F2);
const Color kOxfordBlue = Color(0xFFCD77F2);

const kColorScheme = ColorScheme(
  primary: kDavysGrey,
  primaryContainer: foregroundColor,
  secondary: darkColor,
  secondaryContainer: darkColor,
  surface: kOxfordBlue,
  background: backgroundColor,
  error: Colors.red,
  onPrimary: backgroundColor,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
);
