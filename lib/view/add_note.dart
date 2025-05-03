import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';
import 'package:notes/view/category.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

TextEditingController title = TextEditingController();
TextEditingController cotent = TextEditingController();
TextEditingController category = TextEditingController();
Controler _controler = Get.put(Controler());
ChipControler _controlerch = Get.put(ChipControler());
int? selsectedCategory;

class _AddnoteState extends State<Addnote> {
  Mydb dTb = Mydb();
  @override
  void initState() {
    _controlerch.readCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(3.0).r,
              child: SizedBox(
                height: 20.h,
                child: Text(
                  "Title :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0).r,
              child: Card(
                child: TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0).r,
              child: SizedBox(
                height: 20.h,
                child: Text(
                  "Category :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0).r,
              child: Card(
                child: TextFormField(
                  controller: category,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          showCategoryDialog(context);
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down, size: 40.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0).r,
              child: SizedBox(
                height: 20.h,
                child: Text(
                  "Content :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0).r,
                child: Card(
                  child: TextFormField(
                    maxLines: null,
                    minLines: null,
                    controller: cotent,
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
          final result = await dTb.inserttoDB("notes_db", {
            "title": title.text,
            "content": cotent.text,
            "category_id": selsectedCategory,
          });

          log(
            "task Added is done ==================================================$result",
          );
          _controler.notes.assignAll([
            NoteModel(title: title.text, content: cotent.text),
          ]);

          if (result > 0) {
            title.clear();
            cotent.clear();
            category.clear();

            Get.offNamedUntil(
              '/note_page',
              (route) => route.settings.name == '/',
            );
            Get.snackbar(
              "",
              "Note Added succesfully",
              colorText: bcgDark,
              duration: Duration(seconds: 3),
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
      ),
    );
  }
}

void showCategoryDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsOverflowAlignment: OverflowBarAlignment.end,
        actionsPadding: EdgeInsets.all(0),
        title: Text("Select Category", style: TextStyle(color: three)),
        content: SizedBox(
          height: 200.h,
          width: 150.w,
          child: Obx(
            () => ListView.builder(
              itemCount: _controlerch.chips.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    selsectedCategory = _controlerch.chips[i].chipId;
                    category.text = _controlerch.chips[i].chiplabel.toString();
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(3.0).r,
                    child: ListTile(
                      title: Text('${_controlerch.chips[i].chiplabel}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(0),
              color: bcgDark,
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel", style: TextStyle(color: three)),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(0),
              color: bcgDark,
              child: TextButton(
                onPressed: () {
                  showAddCategoryDialog(context);
                },
                child: Text("add category", style: TextStyle(color: three)),
              ),
            ),
          ),
        ],
      );
    },
  );
}
