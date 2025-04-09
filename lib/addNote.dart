import 'package:flutter/material.dart';
import 'package:notes/MyDb.dart';
import 'package:notes/appColor.dart';
import 'extrnalwidgets.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

TextEditingController title = TextEditingController();
TextEditingController cotent = TextEditingController();

class _AddnoteState extends State<Addnote> {
  Mydb dTb = Mydb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bcgC,
      appBar: AppBar(
        flexibleSpace: textTamplete("Add Note"),
        backgroundColor: primaryColor,
        foregroundColor: textC,
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Card(
              shape: Border(
                bottom: BorderSide(color: secondaryColor),
                right: BorderSide(color: secondaryColor),
              ),
              color: bcgC,
              child: TextField(
                controller: title,
                style: TextStyle(color: textC2, fontSize: 18),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: textC2, fontSize: 24),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              minLines: null,
              style: TextStyle(color: textC2, fontSize: 18),
              controller: cotent,
              decoration: InputDecoration(
                hintText: "Content",
                hintStyle: TextStyle(color: textC2, fontSize: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor.withAlpha(80),
        foregroundColor: textC,
        child: Icon(Icons.done),
        onPressed: () async {
          int result = await dTb.inserttoDB('''
INSERT INTO notes (`name`, `content`) VALUES ('${title.text}', '${cotent.text}')
''');

          print(
            "task Added is done ==================================================$result",
          );
          if (result > 0) {
            title.clear();
            cotent.clear();
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
      ),
    );
  }
}
