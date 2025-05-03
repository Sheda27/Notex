import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/extrnalwidgets.dart';
import 'package:notes/view/add_note.dart';
import 'package:notes/view/add_todo.dart';
import 'package:notes/view/category.dart';
import 'package:notes/view/completed_todos.dart';
import 'package:notes/view/edit_todo.dart';
import 'package:notes/view/editnote.dart';
// import 'package:notes/view/home_page.dart';
import 'package:notes/view/notes_page.dart';
import 'package:notes/view/settings.dart';
import 'package:notes/view/to_do_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeCtrl themeCtrl = Get.put(ThemeCtrl());
  // await ScreenUtil.ensureScreenSize();
  themeCtrl.getThemePref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final ThemeCtrl _themeCtrl = Get.put(ThemeCtrl());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          color: one,
          title: "Notex",
          debugShowCheckedModeBanner: false,
          // themeMode: _themeCtrl.isDark.value ? ThemeMode.light : ThemeMode.dark,
          theme: themeLight(),
          darkTheme: themeDark(),
          initialRoute: '/note_page',
          getPages: [
            // GetPage(name: '/', page: () => HomePage()),
            GetPage(name: '/note_page', page: () => Notespage()),
            GetPage(name: '/add_note', page: () => Addnote()),
            GetPage(name: '/settings', page: () => Settings()),
            GetPage(name: '/edit_note', page: () => EditNote()),
            GetPage(name: '/todos', page: () => ToDoList()),
            GetPage(name: '/categ', page: () => Category()),
            GetPage(name: '/add_todo', page: () => AddTodo()),
            GetPage(name: '/completed_todo', page: () => CompletedTodosPage()),
            GetPage(name: '/edit_todo', page: () => EditTodo()),
          ],
        );
      },
    );
  }
}
