import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:notes/model/color.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/my_db.dart';
import 'package:notes/view/category.dart';

class Notespage extends StatefulWidget {
  const Notespage({super.key});

  @override
  State<Notespage> createState() => _NotespageState();
}

Controler _controler = Get.put(Controler());
ChipControler _controlerch = Get.put(ChipControler());
Mydb _dTb = Mydb();
int? selected;

class _NotespageState extends State<Notespage> {
  @override
  void initState() {
    super.initState();
    _controlerch.readCategoryData();

    _controler.readData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        // _controlerch.readCategoryData();
        return _controler.readData();
      },

      child: Scaffold(
        drawer: buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add_note');
          },
          child: Icon(Icons.add),
        ),

        appBar: AppBar(title: Text("Notes")),
        body: Card(
          child: Column(
            children: [
              Obx(
                () => SizedBox(
                  height: 50.h,
                  width: 0.9.sw,
                  child: Row(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,

                          itemCount: _controlerch.chips.length,
                          itemBuilder: (context, index) {
                            if (_controlerch.chips.isEmpty) {
                              return Text("");
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: GestureDetector(
                                  onTap: () async {
                                    selected = _controlerch.chips[index].chipId;
                                    var result = await _dTb
                                        .selectFromDbByCategory(
                                          "notes_db",
                                          "category_id= $selected",
                                        );
                                    _controler.filterdNotes = List.generate(
                                      result.length,
                                      (i) => NoteModel.fromMap(result[i]),
                                    );
                                    setState(() {
                                      _controler.notes = RxList<NoteModel>.from(
                                        _controler.filterdNotes,
                                      );
                                    });
                                    log('selected category========= $result');
                                  },
                                  child: Chip(
                                    label: Text(
                                      '${_controlerch.chips[index].chiplabel}',
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showAddCategoryDialog(context);
                        },
                        child: Chip(label: Icon(Icons.add, color: four)),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                if (_controler.notes.isEmpty) {
                  return Flexible(
                    child: Center(
                      child: Text(
                        "Add Some Notes",
                        style: TextStyle(fontSize: 25.sp),
                      ),
                    ),
                  );
                } else {
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _controler.notes.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          dragStartBehavior: DragStartBehavior.start,
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  var result = await _dTb.deleteFromDB(
                                    "notes_db",
                                    "id =  ${_controler.notes[index].id} ",
                                  );
                                  if (result > 0) {
                                    _controler.update();
                                    Get.snackbar(
                                      "",
                                      "Note Deleted Succecfully",
                                      colorText: bcgDark,
                                      duration: Duration(seconds: 3),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                    log(
                                      "Deleted successfully=================================================$result",
                                    );

                                    setState(() {
                                      _controler.readData();
                                    });
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
                                    '/edit_note',
                                    arguments: _controler.notes[index],
                                  );
                                },
                                icon: Icons.edit,
                                label: 'edit',
                                backgroundColor: four,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 1).r,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: SizedBox(
                                height: 78.h,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 3,
                                      ).r,
                                  child: ListTile(
                                    title: Text(
                                      " العنوان : ${_controler.notes[index].title} ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      " الموضوع : ${_controler.notes[index].content}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    width: 0.8.sw,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: bcgDark),
          child: const Text(
            'Notex',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          tileColor: Color.fromRGBO(222, 166, 122, 0),

          leading: const Icon(Icons.note, color: Colors.white),
          title: Text('HOME'),
          onTap: () {
            // Handle navigation to All Notes
            Get.toNamed('/note_page');
            log("all notes------------------------------------------");
          },
        ),
        ListTile(
          tileColor: Color.fromRGBO(222, 166, 122, 0),
          leading: const Icon(Icons.category, color: Colors.white),
          title: Text('Categoies'),
          onTap: () {
            // Handle navigation to Add Note
            Get.toNamed('/categ');
            log("add notes------------------------------------------");
          },
        ),
        ListTile(
          tileColor: Color.fromRGBO(222, 166, 122, 0),
          leading: const Icon(Icons.task_alt, color: Colors.white),
          title: Text('To Do List'),
          onTap: () {
            // Handle navigation to Add Note
            Get.toNamed('/todos');
            log("add notes------------------------------------------");
          },
        ),

        ListTile(
          tileColor: Color.fromRGBO(222, 166, 122, 0),

          leading: const Icon(Icons.list, color: Colors.white),
          title: Text('completed todo'),
          onTap: () {
            // Handle navigation to Settings
            Get.toNamed('/completed_todo');
            log("completed todo------------------------------------------");
          },
        ),
        ListTile(
          tileColor: Color.fromRGBO(222, 166, 122, 0),

          leading: const Icon(Icons.settings, color: Colors.white),
          title: Text('Settings'),
          onTap: () {
            // Handle navigation to Settings
            Get.toNamed('/settings');
            log("settings------------------------------------------");
          },
        ),
      ],
    ),
  );
}
