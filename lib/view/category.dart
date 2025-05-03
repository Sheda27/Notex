import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:notes/controller/controler.dart';
import 'package:notes/model/color.dart';
import 'package:notes/model/my_db.dart';
import 'package:notes/view/notes_page.dart';

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
      drawer: buildDrawer(context),
      body: Card(
        child: Obx(() {
          if (controler.chips.isEmpty) {
            return Center(
              child: Text(
                "Add Some Categories",
                style: TextStyle(fontSize: 25.sp),
              ),
            );
          } else {
            return Column(
              children: [
                ListView.builder(
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
                                Get.snackbar(
                                  "",
                                  "Deleted Succecfully",
                                  colorText: bcgDark,
                                  duration: Duration(seconds: 3),
                                  snackPosition: SnackPosition.BOTTOM,
                                );

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
                            backgroundColor: tow,
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              final TextEditingController categoryController =
                                  TextEditingController();
                              categoryController.text =
                                  "${controler.chips[index].chiplabel}";
                              Get.dialog(
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: AlertDialog(
                                    title: Center(child: Text('Edit Category')),
                                    content: TextField(
                                      controller: categoryController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter category name',
                                      ),
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
                                          if (categoryController
                                              .text
                                              .isNotEmpty) {
                                            int result = await dTb.updateDB(
                                              'category',
                                              {
                                                "label":
                                                    categoryController.text,
                                              },
                                              "id =${controler.chips[index].chipId}",
                                            );
                                            log(
                                              "added categ----------- $result",
                                            );
                                            controler.chips.assignAll([
                                              ChipModel(
                                                chiplabel:
                                                    categoryController.text,
                                              ),
                                            ]);
                                            if (result > 0) {
                                              controler.readCategoryData();
                                              Get.snackbar(
                                                "",
                                                "Category Updated Succecfully",
                                                colorText: bcgDark,
                                                duration: Duration(seconds: 3),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                              );
                                              Get.back();
                                            }
                                          }
                                        },
                                        child: Text('Done'),
                                      ),
                                    ],
                                  ),
                                ),

                                arguments: controler.chips[index],
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
                          child: ListTile(
                            title: Text(
                              " ${controler.chips[index].chiplabel} ",
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }),
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
        title: Center(
          child: Text('Add Category', style: TextStyle(color: three)),
        ),
        content: TextField(
          controller: categoryController,
          decoration: InputDecoration(
            hintText: 'Enter category name',
            hintStyle: TextStyle(color: three),
          ),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(0),
              color: bcgDark,
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel", style: TextStyle(color: three)),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(0),
              color: bcgDark,
              child: TextButton(
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
                child: Text('Add', style: TextStyle(color: three)),
              ),
            ),
          ),
        ],
      );
    },
  );
}
