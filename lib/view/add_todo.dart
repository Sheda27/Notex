import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

TextEditingController title = TextEditingController();
TextEditingController disc = TextEditingController();
Mydb dTb = Mydb();
int? x;
String? selectedPriority;
List<String> priority = ["High", 'Low'];
String format = DateFormat('yyyy-MM-dd').format(DateTime.now());

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Card(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0).r,
              child: Text(
                'Enter Todo Details',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0).r,
              child: SizedBox(
                height: 20.h,
                child: Text(
                  "Title :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  // labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0).r,
              child: SizedBox(
                height: 20.h,
                child: Text(
                  "Description :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              child: TextField(
                controller: disc,
                decoration: InputDecoration(
                  // labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            SizedBox(height: 16.h),
            Card(
              child: Row(
                spacing: 130.r,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      int result = await dTb.inserttoDB('todos', {
                        "title": title.text,
                        "discribe": disc.text,
                        "date": format,
                        "priority": x,
                      });
                      log('todo-----------$result');
                      if (result > 0) {
                        Get.snackbar(
                          "",
                          "Task Added succesfully",
                          colorText: bcgDark,
                          duration: Duration(seconds: 3),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Get.offNamedUntil(
                          '/todos',
                          (route) => route.settings.name == '/',
                        );
                        title.clear();
                        disc.clear();
                      }
                    },
                    child: Text('Save'),
                  ),
                  DropdownButton<String>(
                    value: selectedPriority,
                    hint: Text('Priority Level'),
                    items:
                        priority.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPriority = newValue;
                      });
                      if (selectedPriority == priority[0]) {
                        x = 1;
                      } else {
                        x = 2;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
