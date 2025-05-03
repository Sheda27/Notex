import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/model/color.dart';

//light theme
ThemeData themeLight() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: six,
      foregroundColor: three,
      titleTextStyle: TextStyle(color: three, fontSize: 28.sp),
    ),
    cardTheme: CardThemeData(
      color: five,
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
      shadowColor: bcgDark,
      elevation: 3,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: bcgDark.withAlpha(100),
      contentTextStyle: TextStyle(color: three),
      shadowColor: three,
      elevation: 7,
    ),
    scaffoldBackgroundColor: six,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bcgDark),
        foregroundColor: WidgetStatePropertyAll(three),
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: bcgDark.withAlpha(100),
      titleTextStyle: TextStyle(color: three, fontSize: 20),
      subtitleTextStyle: TextStyle(color: three, fontSize: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: one),
      labelStyle: TextStyle(color: one),
      suffixIconColor: six,
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
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(three)),
    ),
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
    drawerTheme: DrawerThemeData(backgroundColor: lay),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: three),
      bodyMedium: TextStyle(color: three),
      bodyLarge: TextStyle(color: three),
      bodySmall: TextStyle(color: three),
    ),

    chipTheme: ChipThemeData(
      side: BorderSide(width: 0.5, color: three),
      backgroundColor: lay.withAlpha(100),
      labelStyle: TextStyle(color: way),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: bcgDark.withAlpha(100),
      contentTextStyle: TextStyle(color: three),
      shadowColor: three,
      elevation: 7,
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
      suffixIconColor: Colors.white,
    ),
    hintColor: three,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lay.withAlpha(400),
      foregroundColor: three,
    ),
  );
}
