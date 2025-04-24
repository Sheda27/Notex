import 'package:flutter/material.dart';
import 'package:notes/model/color.dart';

//light theme
ThemeData themeLight() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: one,
      foregroundColor: three,
      titleTextStyle: TextStyle(color: three, fontSize: 28),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: three),

    scaffoldBackgroundColor: three,
    buttonTheme: ButtonThemeData(buttonColor: secondaryColor),
    listTileTheme: ListTileThemeData(
      tileColor: three.withAlpha(1000),
      titleTextStyle: TextStyle(color: one, fontSize: 20),
      subtitleTextStyle: TextStyle(color: one, fontSize: 16),
    ),

    hintColor: one,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: one.withAlpha(450),
      foregroundColor: three,
    ),
  );
}

// dark theme
ThemeData themeDark() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: one,
      foregroundColor: textDark,
      titleTextStyle: TextStyle(color: three, fontSize: 28),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: bcgDark),
    scaffoldBackgroundColor: bcgDark,
    buttonTheme: ButtonThemeData(buttonColor: secondryDark),
    listTileTheme: ListTileThemeData(
      tileColor: one.withAlpha(70),
      titleTextStyle: TextStyle(color: three, fontSize: 20),
      subtitleTextStyle: TextStyle(color: three, fontSize: 16),
    ),
    hintColor: three,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: one.withAlpha(400),
      foregroundColor: three,
    ),
  );
}
