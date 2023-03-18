import 'dart:developer';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

const dbName = 'places.db';

class Tables {
  static const places = 'places';
}

class DB {
  final sql.Database _db;
  static DB? _instance;

  DB._(this._db);

  static Future<sql.Database> getConnection() async {
    if (_instance == null) {
      final dbPath = await sql.getDatabasesPath();
      final db = await sql.openDatabase(path.join(dbPath, dbName),
          onCreate: (db, version) async {
        log(Tables.places);
        await db.execute(
            'CREATE TABLE ${Tables.places}(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
        log('Created tables');
      }, version: 1);
      _instance = DB._(db);
    }
    return _instance!._db;
  }

  static Future<void> upsert(String table, Map<String, Object> data) async {
    final connection = await getConnection();
    connection.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> list(String table) async {
    final connection = await getConnection();
    return connection.query(table);
  }
}
