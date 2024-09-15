import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLUtils {
  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db!;
    } else {
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final fullDBPath = join(dbPath, "moamen.db");
    final myDb = await openDatabase(fullDBPath,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  Future<void> _onCreate(Database db, int version) async {
    
    db.execute('''
    CREATE TABLE "notes"(
      id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY,
      notes TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {

  }

  readData(String sql) async {
    final myDb = await db;
    final response = myDb.query(sql,where: "id == 0");
    response;
  }

  insertData(String sql) async {
    final myDb = await db;
    final response = myDb.rawInsert(sql);
    response;
  }

  updateData(String sql) async {
    final myDb = await db;
    final response = myDb.rawUpdate(sql);
    response;
  }

  deleteData(String sql) async {
    final myDb = await db;
    final response = myDb.rawDelete(sql);
    response;
  }
}
