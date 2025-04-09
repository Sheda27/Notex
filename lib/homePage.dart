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

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor.withAlpha(80),
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
      body: ListView(
        children: [
          FutureBuilder(
            future: readData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                        color: secondaryColor,
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
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ],
      ),

      drawer: _buildDrawer(context),
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
