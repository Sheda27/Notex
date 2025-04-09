import 'package:flutter/material.dart';
import 'package:notes/appColor.dart';

Widget textTamplete(String text) {
  return Center(
    child: Text(
      text,
      style: TextStyle(color: textC, fontSize: 30, fontWeight: FontWeight.bold),
    ),
  );
}

Widget textTamplete2(String text) {
  return Text(
    text,
    style: TextStyle(color: textC, fontSize: 18, fontWeight: FontWeight.bold),
  );
}
