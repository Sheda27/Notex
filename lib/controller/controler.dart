import 'package:get/get.dart';
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
    notes.assignAll(notesList);
    return notesList;
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
    isDark.value = prefs.getBool('darkmode') ?? false;
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
    chips.assignAll(chipList);
    return chipList;
  }
}
