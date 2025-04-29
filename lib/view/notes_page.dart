import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:notes/model/color.dart';
import 'package:notes/controller/controler.dart';

class Notespage extends StatefulWidget {
  const Notespage({super.key});

  @override
  State<Notespage> createState() => _NotespageState();
}

Controler _controler = Get.put(Controler());
ChipControler _controlerch = Get.put(ChipControler());

int? selected;

class _NotespageState extends State<Notespage> {
  @override
  void initState() {
    _controler.readData();
    _controlerch.readCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add_note');
          },
          child: Icon(Icons.add),
        ),

        appBar: AppBar(title: Text("Notes")),
        body: RefreshIndicator(
          onRefresh: () {
            _controlerch.readCategoryData();
            return _controler.readData();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  itemCount: _controlerch.chips.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: GestureDetector(
                        onTap: () async {
                          // var result = _controler.readDataByCategory(index);
                          selected = _controlerch.chips[index].chipId;
                          var result = await dTb.selectFromDbByCategory(
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
                          label: Text('${_controlerch.chips[index].chiplabel}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(() {
                if (_controler.notes.isEmpty) {
                  return Flexible(
                    child: Center(
                      child: Text(
                        "Add Some Notes",
                        style: TextStyle(fontSize: 25),
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
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  var result = await dTb.deleteFromDB(
                                    "notes_db",
                                    "id =  ${_controler.notes[index].id} ",
                                  );
                                  if (result > 0) {
                                    _controler.update();

                                    log(
                                      "Deleted successfully=================================================$result",
                                    );

                                    setState(() {
                                      _controler.readData();
                                    });
                                  }
                                },
                                borderRadius: BorderRadius.circular(50),
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
                                borderRadius: BorderRadius.circular(50),
                                icon: Icons.edit,
                                label: 'edit',
                                backgroundColor: four,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                  height: 75,
                                  child: Card(
                                    color: const Color.fromARGB(0, 64, 64, 86),
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

        drawer: buildDrawer(context),
      ),
    );
  }
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: one),
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
            Get.toNamed('/');
            log("all notes------------------------------------------");
          },
        ),
        ListTile(
          tileColor: Color.fromRGBO(222, 166, 122, 0),
          leading: const Icon(Icons.add, color: Colors.white),
          title: Text('Add Note'),
          onTap: () {
            // Handle navigation to Add Note
            Get.toNamed('/add_note');
            log("add notes------------------------------------------");
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
