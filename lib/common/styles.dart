import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff300759);
const Color onPrimary = Color(0xffDAD0E1);
const Color secondaryColor = Color(0xFFCD77F2);
const Color onSecondary = Color(0xFFE5B6F2);
const Color foregroundColor = Color(0xff9D1DF2);

TextTheme myTextTheme = const TextTheme(
  displayLarge:
      TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: primaryColor),
  displayMedium: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.white,
    letterSpacing: 1.5,
  ),
  displaySmall: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Colors.white,
    letterSpacing: 1.5,
  ),
);

const kColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: primaryColor,
  onPrimary: secondaryColor,
  secondary: secondaryColor,
  onSecondary: onSecondary,
  error: Colors.red,
  onError: Colors.white,
  background: secondaryColor,
  onBackground: onPrimary,
  surface: primaryColor,
  onSurface: onPrimary,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: kColorScheme,
  scaffoldBackgroundColor: onPrimary,
  tabBarTheme: const TabBarTheme(
    dividerColor: primaryColor,
    labelColor: primaryColor,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w700),
  ),
  iconTheme: const IconThemeData(
    color: primaryColor,
  ),
  cardColor: onSecondary.withOpacity(0.5),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
