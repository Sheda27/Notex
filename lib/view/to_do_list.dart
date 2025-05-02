import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';
import 'package:notes/view/notes_page.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

Mydb dTb = Mydb();
ToDoCtrl _toDoCtrl = Get.put(ToDoCtrl());
var iconBefore = Icon(Icons.check_circle);

class _ToDoListState extends State<ToDoList> {
  @override
  void initState() {
    _toDoCtrl.readToDosData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(title: Text('TODOS')),
      body: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.r,
              children: [
                GestureDetector(
                  onTap: () {
                    _toDoCtrl.readToDosData();
                  },
                  child: Chip(label: Text("All List")),
                ),
                GestureDetector(
                  onTap: () async {
                    //  selected = _controlerch.chips[index].chipId;
                    var result = await dTb.selectFromDbByCategory(
                      "todos",
                      "priority= 1",
                    );
                    _toDoCtrl.filterdTodo = List.generate(
                      result.length,
                      (i) => ToDo.fromMap(result[i]),
                    );
                    setState(() {
                      _toDoCtrl.toDos = RxList<ToDo>.from(
                        _toDoCtrl.filterdTodo,
                      );
                    });
                    log("${_toDoCtrl.filterdTodo}");
                  },
                  child: Chip(label: Text("High Priority")),
                ),
                GestureDetector(
                  onTap: () async {
                    var result = await dTb.selectFromDbByCategory(
                      "todos",
                      "priority= 2",
                    );
                    _toDoCtrl.filterdTodo = List.generate(
                      result.length,
                      (i) => ToDo.fromMap(result[i]),
                    );
                    setState(() {
                      _toDoCtrl.toDos = RxList<ToDo>.from(
                        _toDoCtrl.filterdTodo,
                      );
                    });
                    log("${_toDoCtrl.filterdTodo}");
                  },
                  child: Chip(label: Text("Low Priority")),
                ),
              ],
            ),
            Obx(() {
              if (_toDoCtrl.toDos.isEmpty) {
                return Flexible(
                  child: Center(
                    child: Text(
                      "What You Have To Do??",
                      style: TextStyle(fontSize: 25.sp),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _toDoCtrl.toDos.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              var result = await dTb.deleteFromDB(
                                "todos",
                                "id =${_toDoCtrl.toDos[index].toDoId}   ",
                              );
                              if (result > 0) {
                                _toDoCtrl.toDos.removeAt(index);
                                Get.snackbar(
                                  "",
                                  "Task Deleted Succecfully",
                                  colorText: bcgDark,
                                  duration: Duration(seconds: 3),
                                  snackPosition: SnackPosition.BOTTOM,
                                );

                                log(
                                  "Deleted successfully=================================================$result",
                                );

                                setState(() {});
                              }
                            },
                            icon: Icons.delete,
                            label: 'Delete',
                            backgroundColor: tow,
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Get.toNamed(
                                '/edit_todo',
                                arguments: _toDoCtrl.toDos[index],
                              );
                            },
                            icon: Icons.edit,
                            label: 'edit',
                            backgroundColor: four,
                          ),
                        ],
                      ),
                      child: RPadding(
                        padding: const EdgeInsets.only(top: 1).r,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height: 75.h,
                            child: ListTile(
                              title: Text(
                                " العنوان : ${_toDoCtrl.toDos[index].toDoTitle}  ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                "  ${_toDoCtrl.toDos[index].toDoDate} ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  int result = await dTb.inserttoDB(
                                    "completedtodos",
                                    {"title": _toDoCtrl.toDos[index].toDoTitle},
                                  );
                                  var result2 = await dTb.deleteFromDB(
                                    "todos",
                                    "id =${_toDoCtrl.toDos[index].toDoId}   ",
                                  );
                                  if (result > 0) {
                                    _toDoCtrl.toDos.removeAt(index);

                                    log(
                                      "Deleted successfully=================================================$result2",
                                    );

                                    setState(() {});
                                  }
                                  log('$result');
                                  setState(() {
                                    iconBefore = Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    );
                                  });
                                  Get.snackbar(
                                    "",
                                    "Added to Completed Tasks",
                                    snackPosition: SnackPosition.BOTTOM,
                                    duration: Duration(seconds: 3),
                                    colorText: bcgDark,
                                  );
                                },
                                icon: iconBefore,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add_todo');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
