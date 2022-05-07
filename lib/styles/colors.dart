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
  static Color  primary = Colors.orange[500];
  // Color(0xfffdc500);
  static const tertiary = Color(0xffff36b6b);



  static Color title = const Color(0xDD000000);
  static Color subTitle = const Color(0x8A000000);
  static Color backgroundColor = const Color(0xFFE0E0E0); //grey shade 300

  static Color favColor = const Color(0xFFF44336); // red 500
  static Color favBadgeColor = const Color(0xFFE57373); // red 300

  static Color cartColor = const Color(0xFF5E35B1); //deep purple 600
  static Color cartBadgeColor = const Color(0xFFBA68C8); //purple 300

  static Color gradiendFStart = const Color(0xFFE040FB); //purpleAccent 100
  static Color gradiendFEnd = const Color(0xFFE1BEE7); //purple 100
  static Color endColor = const Color(0xFFCE93D8); //purple 200
  static Color purple300 = const Color(0xFFBA68C8); //purple 300
  static Color gradiendLEnd = const Color(0xFFE91E63); //Pink
  static Color gradiendLStart = const Color(0xFF9C27B0); //purple 500
  static Color starterColor = const Color(0xFF8E24AA); //purple 600
  static Color purple800 = const Color(0xFF6A1B9A);





  static ThemeData lightTheme = ThemeData(
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))
        )
    ),
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
class IconColors {
  static const Color send = Color(0xffecfaf8);
  static const Color transfer = Color(0xfffdeef5);
  static const Color passbook = Color(0xfffff4eb);
  static const Color more = Color(0xffeff1fe);
}

class IconImgs {
  static const String send = "assets/send.png";
  static const String transfer = "assets/transfer.png";
  static const String passbook = "assets/passbook.png";
  static const String more = "assets/more.png";
  static const String freeze = "assets/freeze.png";
  static const String unlock = "assets/unlock.png";
  static const String secret = "assets/secret.png";
}