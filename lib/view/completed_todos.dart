import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';
import 'package:notes/view/notes_page.dart';

class CompletedTodosPage extends StatefulWidget {
  const CompletedTodosPage({super.key});

  @override
  State<CompletedTodosPage> createState() => _CompletedTodosPageState();
}

class _CompletedTodosPageState extends State<CompletedTodosPage> {
  Mydb dTb = Mydb();
  final CompletedToDoCtrl _toDoCtrl = Get.put(CompletedToDoCtrl());
  @override
  void initState() {
    _toDoCtrl.readCompletedToDoData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(title: Text('Completed Todos')),
      body: Card(
        child: Obx(() {
          if (_toDoCtrl.completedToDo.isEmpty) {
            return Center(child: Text("No Tasks Completed"));
          } else {
            return Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9, right: 5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _toDoCtrl.completedToDo.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () async {
                            int result = await dTb.deleteFromDB(
                              "completedtodos",
                              "id =${_toDoCtrl.completedToDo[index].id}",
                            );
                            log("deleted==========$result");
                            if (result > 0) {
                              _toDoCtrl.completedToDo.removeAt(index);
                              Get.snackbar(
                                "",
                                "Deleted Succecfully",
                                colorText: bcgDark,
                                duration: Duration(seconds: 3),
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: ListTile(
                            tileColor: Colors.green[100],
                            textColor: Colors.grey[900],
                            trailing: Text("COMLETED"),
                            title: Text(
                              "${_toDoCtrl.completedToDo[index].title}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
