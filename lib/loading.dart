import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/appColor.dart';
import 'package:notes/extrnalwidgets.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Perform heavy task asynchronously
    Future.microtask(
      () => compute(heavyTask, null).then((_) {
        Navigator.pushReplacementNamed(context, '/home');
      }),
    );
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: secondaryColor),
            SizedBox(height: 10),
            textTamplete2("Loading..."),
          ],
        ),
      ),
    );
  }

  static void heavyTask(dynamic _) {
    for (int i = 0; i < 1000000000; i++) {
      // Simulating heavy computation
    }
  }
}
