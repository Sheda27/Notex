import 'dart:developer';
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
      version: 3,
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
   title TEXT ,
   content TEXT,
   category_id INTEGER,
  FOREIGN KEY (category_id) REFERENCES category (id)
);

''');
    await ocdb.execute('''
   CREATE TABLE category (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   label TEXT
     );
           ''');
    await ocdb.execute('''
   CREATE TABLE todos (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   title TEXT,
   discribe TEXT,
   date TEXT, 
   priority INTEGER
     );
           ''');
    await ocdb.execute('''
   CREATE TABLE completedtodos (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   title TEXT
     );
           ''');
    log("TABLE CREATED-------------------------------");
  }

  //--------- select from db
  selectFromDB(String table) async {
    Database? ocdb = await database;
    List<Map<String, dynamic>> result = await ocdb!.query(table);

    return result;
  }

  //--------- select by category
  selectFromDbByCategory(String table, String where) async {
    Database? ocdb = await database;
    List<Map<String, dynamic>> result = await ocdb!.query(table, where: where);

    return result;
  }

  //--------- insert to db
  inserttoDB(String table, Map<String, Object?> values) async {
    Database? ocdb = await database;
    int result = await ocdb!.insert(table, values);
    return result;
  }

  //--------- update to db
  updateDB(String table, Map<String, Object?> values, String? where) async {
    Database? ocdb = await database;
    int result = await ocdb!.update(table, values, where: where);
    return result;
  }

  //--------- delete from db
  deleteFromDB(String table, String? where) async {
    Database? ocdb = await database;
    int result = await ocdb!.delete(table, where: where);
    return result;
  }

  //--------- drop table
  Future<void> dropFromDB(String table) async {
    Database? ocdb = await database;
    var res = await ocdb!.execute('DROP TABLE IF EXISTS $table');
    return res;
  }
}
