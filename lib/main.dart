import 'package:flutter/material.dart';
import 'package:notes/homePage.dart';
import 'package:notes/loading.dart';
import 'package:notes/addNote.dart';
import 'package:notes/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/home': (context) => Homepage(),
        '/addnote': (context) => Addnote(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
