import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/model/color.dart';

//light theme
ThemeData themeLight() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
      foregroundColor: three,
      titleTextStyle: TextStyle(color: three, fontSize: 28.sp),
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[00],
      shadowColor: bcgDark,
      elevation: 5,
      surfaceTintColor: one,
      margin: EdgeInsets.fromLTRB(7, 0, 0, 0).r,
    ),
    drawerTheme: DrawerThemeData(backgroundColor: three),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: one),
      bodyMedium: TextStyle(color: one),
      bodySmall: TextStyle(color: one),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: bcgDark,
      labelStyle: TextStyle(color: three),
    ),
    scaffoldBackgroundColor: Colors.grey[800],

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bcgDark),
        foregroundColor: WidgetStatePropertyAll(three),
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: bcgDark.withAlpha(100),
      titleTextStyle: TextStyle(color: bcgDark, fontSize: 20),
      subtitleTextStyle: TextStyle(color: bcgDark, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: one),
      labelStyle: TextStyle(color: one),
    ),
    hintColor: one,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: bcgDark.withAlpha(450),
      foregroundColor: three,
    ),
  );
}

// dark theme
ThemeData themeDark() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: lay,
      foregroundColor: way,
      titleTextStyle: TextStyle(color: way, fontSize: 28.sp),
    ),
    cardTheme: CardThemeData(
      color: way,
      shadowColor: three,
      elevation: 5,
      margin: EdgeInsets.fromLTRB(7, 0, 0, 0).r,
    ),
    drawerTheme: DrawerThemeData(backgroundColor: three),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: three),
      bodyMedium: TextStyle(color: three),
      bodySmall: TextStyle(color: three),
    ),
    chipTheme: ChipThemeData(
      side: BorderSide(width: 0.5, color: three),
      backgroundColor: lay.withAlpha(100),
      labelStyle: TextStyle(color: way),
    ),

    scaffoldBackgroundColor: lay,

    listTileTheme: ListTileThemeData(
      tileColor: lay.withAlpha(100),
      titleTextStyle: TextStyle(color: three, fontSize: 20.sp),
      subtitleTextStyle: TextStyle(color: three, fontSize: 16.sp),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: three),
      labelStyle: TextStyle(color: three),
    ),
    hintColor: three,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lay.withAlpha(400),
      foregroundColor: three,
    ),
  );
}
