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
    String path = join(dbpath, 'notes.db');
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
    await ocdb.execute(
      '''ALTER TABEL notes ADD COLUMN content TEXT NOT NULL''',
    );
    print("DATABASE UPGRADED^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
  }

  _onCreate(Database ocdb, int version) async {
    await ocdb.execute('''
   CREATE TABLE notes (
   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
   name TEXT NOT NULL,
   content TEXT NOT NULL
);

''');
    print("TABLE CREATED^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
  }

  /////// select from db
  selectFromDB(String sql) async {
    Database? ocdb = await database;
    List<Map> result = await ocdb!.rawQuery(sql);
    return result;
  }

  ///////// insert to db
  inserttoDB(String sql) async {
    Database? ocdb = await database;
    int result = await ocdb!.rawInsert(sql);
    return result;
  }

  /////// update to db
  updateDB(String sql) async {
    Database? ocdb = await database;
    int result = await ocdb!.rawUpdate(sql);
    return result;
  }

  ///////// delete from db
  deleteFromDB(String sql) async {
    Database? ocdb = await database;
    int result = await ocdb!.rawDelete(sql);
    return result;
  }
}
