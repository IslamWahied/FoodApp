// @dart=2.9
import 'package:flutter/material.dart';

class Constants {
  static String appName = "Restaurant App UI KIT";

  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.red;
  static Color darkAccent = Colors.red[400];
  static Color lightBG = const Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellow[600];
  static const white = Colors.white;
  static const secondary = Color(0xff323335);
  static const lightGray = Color(0xffc0c1c3);
  static const lighterGray = Color(0xffe0e0e0);
  static const black = Colors.black;
  static const primary = Color(0xfffdc912);
  static const tertiary = Color(0xffff36b6b);

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextTheme(
        subtitle1: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyText2,
      titleTextStyle: TextTheme(
        subtitle1: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).headline6,
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: lightAccent),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightAccent),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextTheme(
        subtitle1: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyText2,
      titleTextStyle: TextTheme(
        subtitle1: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).headline6,
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkAccent),
    textSelectionTheme: TextSelectionThemeData(cursorColor: darkAccent),
  );
}
