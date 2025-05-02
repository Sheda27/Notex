import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
TextEditingController edcategory = TextEditingController();
Controler _controler = Get.put(Controler());
ChipControler _controlerch = Get.put(ChipControler());
int? sel;

class _EditNoteState extends State<EditNote> {
  Mydb dTb = Mydb();
  late NoteModel note;

  @override
  void initState() {
    super.initState();
    note = Get.arguments as NoteModel;
    edtitle.text = note.title!;
    edcontent.text = note.content!;
    if (note.categoryId != null) {
      int i = note.categoryId! - 1;

      edcategory.text = "${_controlerch.chips[i].chiplabel}";
      log(
        'recived: ${note.title} -------- recived: ${note.content}-------- recived: ${_controlerch.chips[i].chiplabel}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Note")),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0).r,
              child: Text(
                "Title :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8).r,
              child: Card(
                child: TextFormField(
                  controller: edtitle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0).r,
              child: Text(
                "Category :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 3).r,
              child: Card(
                child: TextFormField(
                  controller: edcategory,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Select Category"),
                                content: SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: _controlerch.chips.length,
                                    itemBuilder: (context, ix) {
                                      return GestureDetector(
                                        onTap: () {
                                          sel = _controlerch.chips[ix].chipId;
                                          setState(() {
                                            edcategory.text =
                                                "${_controlerch.chips[ix].chiplabel}";
                                          });

                                          Get.back();
                                        },
                                        child: Chip(
                                          label: Text(
                                            '${_controlerch.chips[ix].chiplabel}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed('/categ');
                                    },
                                    child: Text("add category"),
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0).r,
              child: Text(
                "Content :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: TextFormField(
                    maxLines: null,
                    minLines: null,
                    controller: edcontent,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () async {
          final result = await dTb.updateDB("notes_db", {
            "title": edtitle.text,
            "content": edcontent.text,
            "category_id": sel,
          }, "id = ${note.id}");

          log(
            "Note updated successfully ==================================================$result",
          );

          if (result > 0) {
            _controler.notes.refresh();

            edtitle.clear();
            edcontent.clear();
            Get.snackbar(
              "",
              "Note Updated Succecfully",
              colorText: bcgDark,
              duration: Duration(seconds: 3),
              snackPosition: SnackPosition.BOTTOM,
            );

            Get.offNamed('/note_page');
          }
        },
      ),
    );
  }
}

// void edshowCategoryDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return
//     },
//   );
// }
