import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqldb {
  Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await init();
      return _db;
    } else {
      return _db;
    }
  }

  init() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'academe.db');
    Database mydb = await openDatabase(path,
        version: 12, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE attendance(id TEXT PRIMARY KEY, name TEXT,gender TEXT,date TEXT)');
    await db.execute(
        'CREATE TABLE subjects(passcode TEXT PRIMARY KEY, name TEXT, level TEXT, doctor TEXT, start TEXT, end TEXT, day TEXT, open INTEGER)');
    await db.execute('''
          CREATE TABLE likes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            liked TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE quizzes (
            id TEXT PRIMARY KEY,
            quiz TEXT NOT NULL
          )
          ''');

    log('created=============================');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {}
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, data);
    return response;
  }

  insertORReplaceData(Map<String, dynamic> data) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert('''
    INSERT OR REPLACE INTO subjects (name, level, doctor,open ,passcode,start,end,day)
    VALUES (?, ?, ?, ?,?,?,?,?)
  ''', [
      data['name'],
      data['level'],
      data['doctor'],
      data['open'],
      data['passcode'],
      data['start'],
      data['end'],
      data['day'],
    ]);
    return response;
  }

  updateData(
      String table, String id, Map<String, dynamic> data, String key) async {
    Database? mydb = await db;
    int response = await mydb!.update(
      table,
      data,
      where: '$key = ?',
      whereArgs: [id],
    );
    return response;
  }

  deleteData(String table, String id, String key) async {
    Database? mydb = await db;
    int response =
        await mydb!.delete(table, where: '$key = ?', whereArgs: [id]);
    return response;
  }

  deleteAllRows(String table) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table);
    return response;
  }
}
