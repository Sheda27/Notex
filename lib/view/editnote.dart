import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/my_db.dart';
import 'package:notes/view/add_note.dart';

@immutable
class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

TextEditingController edtitle = TextEditingController();
TextEditingController edcontent = TextEditingController();
TextEditingController edcategory = TextEditingController();
Controler _controler = Get.put(Controler());

class _EditNoteState extends State<EditNote> {
  Mydb dTb = Mydb();
  late NoteModel note;
  int? sel;
  @override
  void initState() {
    super.initState();
    note = Get.arguments as NoteModel;
    edtitle.text = note.title!;
    edcontent.text = note.content!;
    edcategory.text = note.categoryId!.toString();
    log(
      'recived: ${note.title} -------- recived: ${note.content}-------- recived: ${note.categoryId}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Note")),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
              controller: edtitle,
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
              controller: edcategory,
              decoration: InputDecoration(
                hintText: "category",
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      showCategoryDialog(context);
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
          ),

          Expanded(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async {
          //           final result = await dTb.updateDB('''
          // UPDATE notes_db
          // SET title = '${edtitle.text}', content = '${edcontent.text}'
          // WHERE id = ${note.id}
          // ''');
          final result = await dTb.updateDB("notes_db", {
            "title": edtitle.text,
            "content": edcontent.text,
            "category_id": edcategory.text,
          }, "id = ${note.id}");

          log(
            "Note updated successfully ==================================================$result",
          );

          if (result > 0) {
            _controler.notes.refresh();

            edtitle.clear();
            edcontent.clear();

            Get.offNamed('/note_page');
          }
        },
      ),
    );
  }
}
