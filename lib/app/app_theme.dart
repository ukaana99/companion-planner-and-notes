import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color inactiveIconColor = const Color(0xFF7F7F7F);

  static Color lightPrimaryColor = const Color(0xFFFF724D);
  static Color lightSecondaryColor = const Color(0xFF06113C);
  static Color lightTertiaryColor = const Color(0xFFDDDDDD);
  static Color lightQuaternaryColor = const Color(0xFFEEEEEE);
  static Color lightBackgroundColor = const Color(0xFFFFFFFF);
  static Color lightBackgroundOverlay = const Color(0x0B000000);

  static Color darkPrimaryColor = const Color(0xFF3D84E4);
  static Color darkSecondaryColor = const Color(0XFF03045E);
  static Color darkTertiaryColor = const Color(0xFF00B4D8);
  static Color darkQuaternaryColor = const Color(0xFF90E0EF);
  static Color darkBackgroundColor = const Color(0xFF1A1A1A);
  static Color darkBackgroundOverlay = const Color(0x0BFFFFFF);

  static Color lightTextColor = const Color(0xDD000000);
  static Color darkTextColor = const Color(0xDDFFFFFF);
  static Color hintColor = const Color(0xFF9E9E9E);

  static AppBarTheme appBarTheme = const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Color(0xFF7F7F7F)),
    actionsIconTheme: IconThemeData(color: Color(0xFF7F7F7F)),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
  );

  static TextStyle titleTextStyle = const TextStyle(
    color: Color(0xFF7F7F7F),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextTheme textTheme = const TextTheme(
    headline1: TextStyle(
      color: Color(0xFF7F7F7F),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: Color(0xFF7F7F7F),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Color(0xFF7F7F7F),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Color(0xFF7F7F7F),
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      color: Color(0xFF7F7F7F),
      fontSize: 16,
    ),
  );

  const AppTheme._();

  static ThemeData get light => ThemeData(
        appBarTheme: appBarTheme.copyWith(
          backgroundColor: lightBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle:
              appBarTheme.titleTextStyle?.copyWith(color: lightTextColor),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: lightPrimaryColor,
          selectionColor: lightPrimaryColor,
          selectionHandleColor: lightPrimaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: hintColor,
          labelStyle: TextStyle(
            color: hintColor,
            decorationColor: hintColor,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: hintColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hintColor),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: lightPrimaryColor,
            backgroundColor: Colors.transparent,
            side: BorderSide(color: lightPrimaryColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: lightPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        textTheme: textTheme,
        brightness: Brightness.light,
        primaryColor: lightPrimaryColor,
        backgroundColor: lightBackgroundColor,
        scaffoldBackgroundColor: lightBackgroundColor,
        focusColor: lightTextColor,
        hintColor: hintColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData get dark => ThemeData(
        appBarTheme: appBarTheme.copyWith(
          backgroundColor: darkBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle:
              appBarTheme.titleTextStyle?.copyWith(color: darkTextColor),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: darkPrimaryColor,
          selectionColor: darkPrimaryColor,
          selectionHandleColor: darkPrimaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: hintColor,
          labelStyle: TextStyle(
            color: hintColor,
            decorationColor: hintColor,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: hintColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hintColor),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: darkPrimaryColor,
            backgroundColor: Colors.transparent,
            side: BorderSide(color: darkPrimaryColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: darkPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        textTheme: textTheme,
        brightness: Brightness.dark,
        primaryColor: darkPrimaryColor,
        backgroundColor: darkBackgroundColor,
        scaffoldBackgroundColor: darkBackgroundColor,
        focusColor: darkTextColor,
        hintColor: hintColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    // Brightness brightness =
    //     themeMode == ThemeMode.light ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(
        // SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent,
        //   statusBarIconBrightness: brightness,
        //   systemNavigationBarIconBrightness: brightness,
        //   systemNavigationBarColor: themeMode == ThemeMode.light
        //       ? lightBackgroundColor
        //       : darkBackgroundColor,
        //   systemNavigationBarDividerColor: Colors.transparent,
        // ),
        themeMode == ThemeMode.light
            ? SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
              )
            : SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
              ));
  }
}

extension ThemeExtras on ThemeData {
  Color get inactiveIconColor => AppTheme.inactiveIconColor;
  Color get backgroundOverlay => brightness == Brightness.light
      ? AppTheme.lightBackgroundOverlay
      : AppTheme.darkBackgroundOverlay;
  Color get textColor => brightness == Brightness.light
      ? AppTheme.lightTextColor
      : AppTheme.darkTextColor;
  Color get secondaryColor => brightness == Brightness.light
      ? AppTheme.lightSecondaryColor
      : AppTheme.darkSecondaryColor;
  Color get tertiaryColor => brightness == Brightness.light
      ? AppTheme.lightTertiaryColor
      : AppTheme.darkTertiaryColor;
  Color get quaternaryColor => brightness == Brightness.light
      ? AppTheme.lightQuaternaryColor
      : AppTheme.darkQuaternaryColor;
}
