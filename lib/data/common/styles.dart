import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff300759);
const Color onPrimary = Color(0xffDAD0E1);
const Color secondaryColor = Color(0xFFCD77F2);
const Color onSecondary = Color(0xFFE5B6F2);
const Color foregroundColor = Color(0xff9D1DF2);

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
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    indicator: BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.grey,
        Colors.grey.shade900,
      ]),
      borderRadius: BorderRadius.circular(30),
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
  tabBarTheme: TabBarTheme(
    dividerColor: primaryColor,
    labelColor: primaryColor,
    unselectedLabelColor: foregroundColor,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    indicator: BoxDecoration(
        gradient: const LinearGradient(colors: [foregroundColor, onSecondary]),
        borderRadius: BorderRadius.circular(30),
        color: secondaryColor),
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
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
