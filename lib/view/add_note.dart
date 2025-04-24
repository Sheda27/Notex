import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

TextEditingController title = TextEditingController();
TextEditingController cotent = TextEditingController();
Controler _controler = Get.find();

class _AddnoteState extends State<Addnote> {
  Mydb dTb = Mydb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextField(
              controller: title,
              style: TextStyle(color: textC2, fontSize: 18),
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 24),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
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
                hintStyle: TextStyle(fontSize: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async {
          final result = await dTb.inserttoDB('''
INSERT INTO notes_db (`title`, `content`) VALUES ('${title.text}', '${cotent.text}')
''');

          log(
            "task Added is done ==================================================$result",
          );
          _controler.notes.assign(
            NoteModel(title: title.text, content: cotent.text),
          );
          if (result > 0) {
            title.clear();
            cotent.clear();

            Get.offNamed('/');
          }
        },
      ),
    );
  }
}
