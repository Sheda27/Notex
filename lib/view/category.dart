import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/my_db.dart';

Mydb dTb = Mydb();
final ChipControler controler = Get.put(ChipControler());

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    controler.readCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CATEGORY')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            if (controler.chips.isEmpty) {
              return Center(
                child: Text(
                  "Add Some Categories",
                  style: TextStyle(fontSize: 25),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controler.chips.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              var result = await dTb.deleteFromDB(
                                "category",
                                "id =  ${controler.chips[index].chipId} ",
                              );
                              if (result > 0) {
                                controler.update();

                                log(
                                  "Deleted successfully=================================================$result",
                                );

                                setState(() {
                                  controler.readCategoryData();
                                });
                              }
                            },
                            icon: Icons.delete,
                            label: 'Delete',
                            backgroundColor: Color.fromARGB(255, 129, 38, 38),
                          ),
                        ],
                      ),
                      // endActionPane: ActionPane(
                      //   motion: StretchMotion(),
                      //   children: [
                      //     SlidableAction(
                      //       onPressed: (context) {
                      //         Get.toNamed(
                      //           '/edit_note',
                      //           arguments: controler.chips[index],
                      //         );
                      //       },

                      //       icon: Icons.edit,
                      //       label: 'edit',
                      //       backgroundColor: Color.fromRGBO(231, 147, 44, 1),
                      //     ),
                      // ],
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            title: Text(
                              " ${controler.chips[index].chiplabel} :",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddCategoryDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void showAddCategoryDialog(BuildContext context) {
  final TextEditingController categoryController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Category'),
        content: TextField(
          controller: categoryController,
          decoration: InputDecoration(hintText: 'Enter category name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (categoryController.text.isNotEmpty) {
                int result = await dTb.inserttoDB('category', {
                  "label": categoryController.text,
                });
                log("added categ----------- $result");
                controler.chips.assignAll([
                  ChipModel(chiplabel: categoryController.text),
                ]);
                if (result > 0) {
                  controler.readCategoryData();
                  Get.back();
                }
              }
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}
