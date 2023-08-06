import 'package:flutter/cupertino.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../common/encrypt.dart';
import '../models/database_model/surah_tabel.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;
  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tableSurah = 'Surah';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/surah.db';

    debugPrint(databasePath);

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('Your secure password'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableSurah(
        number INTEGER PRIMARY KEY,
        sequence INTEGER,
        numberOfVerses INTEGER,
        name BLOB,
        revelation BLOB,
        tafsir BLOB,
        category TEXT
      );
    ''');
  }

  Future<void> insertCacheTransaction(
      List<SurahTable> allSurah, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final surah in allSurah) {
        final surahJson = surah.toJson();
        surahJson['category'] = category;
        txn.insert(_tableSurah, surahJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheAllSurah(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tableSurah,
      where: 'category = ?',
      whereArgs: [category],
    );
    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tableSurah,
      where: 'category = ?',
      whereArgs: [category],
    );
  }
}
