import 'dart:developer';

import 'package:get/get.dart';
import 'package:notes/model/extrnalwidgets.dart';
import 'package:notes/model/my_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

Mydb dTb = Mydb();

class NoteModel {
  final int? id;
  final String? title;
  final String? content;
  final int? categoryId;
  NoteModel({this.id, this.title, this.content, this.categoryId});

  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'category_id': categoryId,
    };

    return map;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      categoryId: map['category_id'],
    );
  }
}

class Controler extends GetxController {
  //notes list
  var notes = <NoteModel>[].obs;
  var filterdNotes = [];
  @override
  void onInit() {
    readData();
    super.onInit();
  }

  //notes provider
  Future<List<NoteModel>> readData() async {
    final result = await dTb.selectFromDB('notes_db');
    final notesList = List.generate(
      result.length,
      (i) => NoteModel.fromMap(result[i]),
    );
    log('$result');
    notes.assignAll(notesList);
    return notesList;
  }
}

class ToDo {
  final int? toDoId;
  final String? toDoTitle;
  final String? toDoDisc;
  final String? toDoDate;
  final int? toDoPriority;
  ToDo({
    this.toDoId,
    this.toDoTitle,
    this.toDoDisc,
    this.toDoDate,
    this.toDoPriority,
  });

  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    var map = <String, dynamic>{
      'id': toDoId,
      'title': toDoTitle,
      'discribe': toDoDisc,
      'date': toDoDate,
      'priority': toDoPriority,
    };

    return map;
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      toDoId: map['id'],
      toDoTitle: map['title'],
      toDoDisc: map['discribe'],
      toDoDate: map['date'],
      toDoPriority: map['priority'],
    );
  }
}

class ToDoCtrl extends GetxController {
  //notes list
  var toDos = <ToDo>[].obs;
  var filterdTodo = [];
  @override
  void onInit() {
    readToDosData();
    super.onInit();
  }

  //notes provider
  Future<List<ToDo>> readToDosData() async {
    final result = await dTb.selectFromDB('todos');
    final todoList = List.generate(
      result.length,
      (i) => ToDo.fromMap(result[i]),
    );
    log('$result');
    toDos.assignAll(todoList);
    update();
    return todoList;
  }
}

class CompletedToDoModel {
  int? id;
  String? title;
  CompletedToDoModel({this.id, this.title});

  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    var map = <String, dynamic>{'id': id, 'title': title};

    return map;
  }

  factory CompletedToDoModel.fromMap(Map<String, dynamic> map) {
    return CompletedToDoModel(id: map['id'], title: map['title']);
  }
}

class CompletedToDoCtrl extends GetxController {
  //notes list
  var completedToDo = <CompletedToDoModel>[].obs;
  @override
  void onInit() {
    readCompletedToDoData();
    super.onInit();
  }

  //notes provider
  Future<List<CompletedToDoModel>> readCompletedToDoData() async {
    final result = await dTb.selectFromDB('completedtodos');
    final completedToDoList = List.generate(
      result.length,
      (i) => CompletedToDoModel.fromMap(result[i]),
    );
    log('$result');
    completedToDo.assignAll(completedToDoList);
    update();
    return completedToDoList;
  }
}

class ThemeCtrl extends GetxController {
  //theme controller
  RxBool isDark = false.obs;
  //set theme preference value
  Future<void> setThemePref(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkmode', isDark.value);
    isDark.value = state;
    update();
  }

  //get theme preference value
  void getThemePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('darkmode') ?? false;
    Get.changeTheme(isDark.value ? themeDark() : themeLight());
    update();
  }
}

class ChipModel {
  final int? chipId;
  final String? chiplabel;

  ChipModel({this.chipId, this.chiplabel});

  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    var map = <String, dynamic>{'id': chipId, 'label': chiplabel};

    return map;
  }

  factory ChipModel.fromMap(Map<String, dynamic> map) {
    return ChipModel(chipId: map['id'], chiplabel: map['label']);
  }
}

class ChipControler extends GetxController {
  //notes list
  var chips = <ChipModel>[].obs;
  var selectedCategory = ''.obs;
  @override
  void onInit() {
    readCategoryData();
    super.onInit();
  }

  //notes provider
  Future<List<ChipModel>> readCategoryData() async {
    final result = await dTb.selectFromDB('category');
    final chipList = List.generate(
      result.length,
      (i) => ChipModel.fromMap(result[i]),
    );
    log('$result');
    chips.assignAll(chipList);
    return chipList;
  }
}
