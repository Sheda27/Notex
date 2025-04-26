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

class _NotespageState extends State<Notespage> {
  @override
  void initState() {
    _controler.readData();

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (_controler.notes.isEmpty) {
                return Center(
                  child: Text("Add Some Notes", style: TextStyle(fontSize: 25)),
                );
              } else {
                return Expanded(
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
                                  'DELETE FROM notes_db WHERE id = ${_controler.notes[index].id}',
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
                              icon: Icons.delete,
                              label: 'Delete',
                              backgroundColor: Color.fromARGB(255, 129, 38, 38),
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
                              backgroundColor: Color.fromRGBO(231, 147, 44, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ExpansionTile(
                              title: Text(
                                " ${_controler.notes[index].title} :",
                              ),
                              children: [
                                Text(" ${_controler.notes[index].content}"),
                              ],
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
