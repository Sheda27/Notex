import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';
// import 'package:notes/view/category.dart';

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
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
              controller: title,
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
              controller: category,

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
          SizedBox(height: 2, child: Container(color: three)),
          Expanded(
            child: TextFormField(
              maxLines: null,
              minLines: null,
              controller: cotent,
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

            Get.offNamed('/note_page');
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
        // backgroundColor: one.withAlpha(50),
        title: Text("Select Category" /*style: TextStyle(color: three)*/),
        content: SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: _controlerch.chips.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  selsectedCategory = _controlerch.chips[i].chipId;
                  category.text = _controlerch.chips[i].chiplabel.toString();
                  Get.back();
                },
                child: Chip(label: Text('${_controlerch.chips[i].chiplabel}')),
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
}
