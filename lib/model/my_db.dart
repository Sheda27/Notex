import 'dart:developer';

import 'package:notes/controller/controler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Mydb {
  static Database? _database;
  Future<Database?> get database async {
    if (_database == null) {
      _database = await initialDB();
      return _database;
    } else {
      return _database;
    }
  }

  initialDB() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'notex.db');
    Database database = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
    return database;
  }

  _onUpgrade(Database ocdb, int oldVersion, int newVersion) async {
    ////////// this function is used to upgrade the database when the version is changed
  }

  _onCreate(Database ocdb, int version) async {
    await ocdb.execute('''
   CREATE TABLE notes_db (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   title TEXT NOT NULL,
   content TEXT NOT NULL
);

''');
    log("TABLE CREATED^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
  }

  //--------- select from db
  selectFromDB(String sql) async {
    Database? ocdb = await database;
    List<Map<String, dynamic>> result = await ocdb!.rawQuery(sql);

    return List.generate(result.length, (i) => NoteModel.fromMap(result[i]));
  }

  //--------- insert to db
  inserttoDB(String sql) async {
    Database? ocdb = await database;
    int result = await ocdb!.rawInsert(sql);
    return result;
  }

  //--------- update to db
  updateDB(String sql) async {
    Database? ocdb = await database;
    int result = await ocdb!.rawUpdate(sql);
    return result;
  }

  //--------- delete from db
  deleteFromDB(String sql) async {
    Database? ocdb = await database;
    int result = await ocdb!.rawDelete(sql);
    return result;
  }
}
