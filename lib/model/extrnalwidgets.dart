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
    textTheme: TextTheme(
      titleMedium: TextStyle(color: one),
      bodyMedium: TextStyle(color: one),
      bodySmall: TextStyle(color: one),
    ),
    scaffoldBackgroundColor: three,
    buttonTheme: ButtonThemeData(buttonColor: secondaryColor),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: three.withAlpha(1000),
      textColor: one,
      collapsedTextColor: one,
      collapsedBackgroundColor: three.withAlpha(100),
      expandedAlignment: Alignment.topRight,
      childrenPadding: EdgeInsets.only(right: 20),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: three.withAlpha(1000),
      titleTextStyle: TextStyle(color: one, fontSize: 20),
      subtitleTextStyle: TextStyle(color: one, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: one),
      labelStyle: TextStyle(color: one),
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
      backgroundColor: bcgC,
      foregroundColor: textDark,
      titleTextStyle: TextStyle(color: three, fontSize: 28),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: three),
      bodyMedium: TextStyle(color: three),
      bodySmall: TextStyle(color: three),
    ),

    drawerTheme: DrawerThemeData(backgroundColor: bcgDark),
    scaffoldBackgroundColor: one,
    buttonTheme: ButtonThemeData(buttonColor: secondryDark),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: one.withAlpha(70),
      textColor: three,
      collapsedTextColor: three,
      collapsedBackgroundColor: one.withAlpha(150),
      expandedAlignment: Alignment.topRight,
      childrenPadding: EdgeInsets.only(right: 20),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: one.withAlpha(70),
      titleTextStyle: TextStyle(color: three, fontSize: 20),
      subtitleTextStyle: TextStyle(color: three, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: three),
      labelStyle: TextStyle(color: three),
    ),
    hintColor: three,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: one.withAlpha(400),
      foregroundColor: three,
    ),
  );
}
