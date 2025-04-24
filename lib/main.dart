import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/extrnalwidgets.dart';
import 'package:notes/view/add_note.dart';
import 'package:notes/view/homePage.dart';
import 'package:notes/view/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeCtrl _themeCtrl = Get.put(ThemeCtrl());
  await _themeCtrl.getThemePref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeCtrl _themeCtrl = Get.put(ThemeCtrl());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: one,
      title: "Notex",
      debugShowCheckedModeBanner: false,
      themeMode: _themeCtrl.isDark.value ? ThemeMode.dark : ThemeMode.light,
      theme: themeLight(),
      darkTheme: themeDark(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Homepage()),
        GetPage(name: '/addnote', page: () => Addnote()),
        GetPage(name: '/settings', page: () => Settings()),
      ],
    );
  }
}
