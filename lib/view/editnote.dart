import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';

@immutable
class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

TextEditingController edtitle = TextEditingController();
TextEditingController edcontent = TextEditingController();
Controler _controler = Get.find();

class _EditNoteState extends State<EditNote> {
  Mydb dTb = Mydb();
  late NoteModel note;
  @override
  void initState() {
    super.initState();
    note = Get.arguments as NoteModel;
    edtitle.text = note.title!;
    edcontent.text = note.content!;
    log('recived: ${note.title} -------- recived: ${note.content}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Note")),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Card(
              color: four,
              child: TextFormField(
                controller: edtitle,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 2, child: Container(color: three)),
          Expanded(
            child: Card(
              color: four,
              child: TextFormField(
                maxLines: null,
                minLines: null,
                controller: edcontent,
                decoration: InputDecoration(
                  hintText: "Content",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async {
          final result = await dTb.updateDB('''
UPDATE notes_db 
SET title = '${edtitle.text}', content = '${edcontent.text}' 
WHERE id = ${note.id}
''');

          log(
            "Note updated successfully ==================================================$result",
          );

          if (result > 0) {
            _controler.notes.refresh();

            edtitle.clear();
            edcontent.clear();

            Get.offNamed('/');
          }
        },
      ),
    );
  }
}
