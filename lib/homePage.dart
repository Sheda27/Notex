import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes/MyDb.dart';
import 'package:notes/appColor.dart';
import 'extrnalwidgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

Mydb dTb = Mydb();
Future<List<Map>> readData() async {
  List<Map> result = await dTb.selectFromDB('SELECT * FROM notes');
  return result;
}

Future<List<Map>> readDatach() async {
  List<Map> result = await dTb.selectFromDB('SELECT * FROM chips');
  return result;
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // bottomSheet: IconButton(
        //   icon: Icon(Icons.delete),
        //   onPressed: () async {
        //     int result = await dTb.deleteFromDB(
        //       'DELETE FROM chips WHERE id = 3',
        //     );
        //     if (result > 0) {
        //       print(
        //         "Deleted successfully=================================================$result",
        //       );
        //       Navigator.pushReplacementNamed(context, '/home');
        //     }
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          foregroundColor: textC,
          onPressed: () {
            Navigator.pushNamed(context, '/addnote');
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: bcgC,
        appBar: AppBar(
          flexibleSpace: textTamplete("Notes"),
          backgroundColor: primaryColor,
          foregroundColor: textC,
        ),
        body: Column(
          children: [
            Row(
              spacing: 3,
              children: [
                FutureBuilder(
                  future: readDatach(),
                  builder: (context, snapshotch) {
                    if (snapshotch.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshotch.hasData && snapshotch.data != null) {
                      return SizedBox(
                        height: 50,
                        width: 300,
                        child: ListView.builder(
                          physics: ScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshotch.data!.length,
                          itemBuilder: (context, indexch) {
                            return chipTemplate(
                              label1: Text(
                                "${snapshotch.data![indexch]['namech']}",
                                style: TextStyle(color: textC, fontSize: 21),
                              ),

                              color1: secondaryColor.withAlpha(130),
                              onSelected1: (selected) {
                                if (selected) {
                                  print(
                                    "Selected chip: ${snapshotch.data![indexch]['namech']}",
                                  );
                                } else {
                                  print(
                                    "Unselected chip: ${snapshotch.data![indexch]['namech']}",
                                  );
                                }
                              },
                              onDelete1: (delete) async {
                                int result = await dTb.deleteFromDB(
                                  'DELETE FROM chips WHERE id = ${snapshotch.data![indexch]['id']}',
                                );
                                print('deleted===================$result');

                                setState(() {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                });
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Text("");
                    }
                  },
                ),
                Card(
                  margin: EdgeInsets.only(left: 7, top: 10, bottom: 10),
                  color: secondaryColor.withAlpha(250),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) => chipdialog(context),
                        );
                      });
                      print(
                        "add chip------------------------------------------",
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: readData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  int result = await dTb.deleteFromDB(
                                    'DELETE FROM notes WHERE id = ${snapshot.data![index]['id']}',
                                  );
                                  if (result > 0) {
                                    print(
                                      "Deleted successfully=================================================$result",
                                    );

                                    setState(() {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/home',
                                      );
                                    });
                                  }
                                },
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  129,
                                  38,
                                  38,
                                ),
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    ////////
                                  });
                                },
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  141,
                                  92,
                                  20,
                                ),
                                icon: Icons.edit,
                                label: 'edit',
                              ),
                            ],
                          ),
                          child: Card(
                            color: secondaryColor.withAlpha(250),
                            child: ListTile(
                              title: textTamplete2(
                                "Title: ${snapshot.data![index]['name']}",
                              ),
                              subtitle: textTamplete2(
                                "Subtitle: ${snapshot.data![index]['content']}",
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Text(' ');
                }
              },
            ),
          ],
        ),

        drawer: _buildDrawer(context),
      ),
    );
  }
}

Drawer _buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: bcgC,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: primaryColor),
          child: const Text(
            'Notes App',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.note, color: Colors.white),
          title: textTamplete2('All Notes'),
          onTap: () {
            // Handle navigation to All Notes
            Navigator.pushReplacementNamed(context, '/home');
            print("all notes------------------------------------------");
          },
        ),
        ListTile(
          leading: const Icon(Icons.add, color: Colors.white),
          title: textTamplete2('Add Note'),
          onTap: () {
            // Handle navigation to Add Note
            Navigator.pushReplacementNamed(context, '/addnote');
            print("add notes------------------------------------------");
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.white),
          title: textTamplete2('Settings'),
          onTap: () {
            // Handle navigation to Settings
            Navigator.pushReplacementNamed(context, '/addnote');
            print("settings------------------------------------------");
          },
        ),
      ],
    ),
  );
}

String? label1;
Color? color;
void onSelected(bool selected) {
  if (selected) {
    color = secondaryColor.withAlpha(130);
    print("Selected chip: $label1");
  } else {
    color = primaryColor;
    print("Unselected chip: $label1");
  }
}

Widget chipTemplate({
  required Text label1,
  required Color color1,
  required Function(dynamic selected) onSelected1,
  required Function(bool delete) onDelete1,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    child: GestureDetector(
      onTap: () {
        onSelected1(true);
      },
      onLongPress: () {
        onDelete1(true);
      },
      child: Chip(
        label: label1,
        backgroundColor: color ?? secondaryColor.withAlpha(250),
      ),
    ),
  );
}

Widget chipdialog(context) {
  return Dialog(
    backgroundColor: secondaryColor.withAlpha(50),
    child: Container(
      height: 200,
      width: 200,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: textC, fontSize: 24),
                onChanged: (value) {
                  label1 = value;
                },
                decoration: const InputDecoration(hintText: 'Enter chip name'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                int result = await dTb.inserttoDB(
                  'INSERT INTO chips (namech) VALUES ("$label1")',
                );
                if (result > 0) {
                  print(
                    "Inserted successfully'''''''''''''''''''''''''''''''''''''''''''",
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: const Text('Add Chip'),
            ),
          ],
        ),
      ),
    ),
  );
}
