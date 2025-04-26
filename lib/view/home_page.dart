import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes/model/color.dart';
import 'package:notes/view/notes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NOTEX')),
      drawer: buildDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  gradient: LinearGradient(
                    colors: <Color>[one, bcgC],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                height: 170,
                child: Center(
                  child: Text(
                    'HI THERE !!',
                    style: TextStyle(fontSize: 50, color: three),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: [
                  Container(
                    height: 120,

                    decoration: BoxDecoration(
                      color: primaryColor,
                      gradient: LinearGradient(
                        colors: <Color>[one, bcgC],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed('/note_page');
                      },
                      icon: Column(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: Image(
                              image: AssetImage('lib/images/note.png'),
                            ),
                          ),
                          Text('NOTES', style: TextStyle(color: three)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      gradient: LinearGradient(
                        colors: <Color>[one, bcgC],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed('/todos');
                      },
                      icon: Column(
                        children: [
                          Image(image: AssetImage('lib/images/todos.png')),
                          Text('TO DO LIST', style: TextStyle(color: three)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      gradient: LinearGradient(
                        colors: <Color>[one, bcgC],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed('/categ');
                      },
                      icon: Column(
                        children: [
                          SizedBox(height: 30),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Icon(Icons.category, color: three, size: 80),
                          ),
                          Text('CATEGORY', style: TextStyle(color: three)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      gradient: LinearGradient(
                        colors: <Color>[one, bcgC],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed('/settings');
                      },
                      icon: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Icon(Icons.settings, color: three, size: 80),
                          ),
                          Text('SETTINGS', style: TextStyle(color: three)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/add_note');
            },
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(bcgC)),
            child: Text('ADD NOTE', style: TextStyle(color: three)),
          ),
        ],
      ),
    );
  }
}
