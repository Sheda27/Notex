import 'package:get/get.dart';
import 'package:notes/model/my_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

Mydb dTb = Mydb();

class NoteModel {
  final int? id;
  final String? title;
  final String? content;
  NoteModel({this.id, this.title, this.content});

  Map<String, dynamic> toMap(Map<String, dynamic> map) {
    var map = <String, dynamic>{'id': id, 'title': title, 'content': content};

    return map;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}

class Controler extends GetxController {
  //notes list
  var notes = <NoteModel>[].obs;
  @override
  void onInit() {
    readData();
    super.onInit();
  }

  //notes provider
  Future<List<NoteModel>> readData() async {
    final result = await dTb.selectFromDB('SELECT * FROM notes_db');
    notes.assignAll(result);
    return result;
  }
}

class ThemeCtrl extends GetxController {
  //theme controller
  RxBool isDark = false.obs;
  //set theme preference value
  Future<void> setThemePref(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkmode', isDark.value);
    isDark = isDark.value.obs;
  }

  //get theme preference value
  Future<void> getThemePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('darkmode')!;
  }
}
