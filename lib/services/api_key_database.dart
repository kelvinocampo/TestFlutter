import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/api_key_model.dart';
import 'gemini_service.dart';

class ApiKeyDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'apikeys.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE api_keys (
          key_id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE,
          key TEXT NOT NULL UNIQUE,
          is_active INTEGER NOT NULL
        )
      ''');
      },
    );
  }

  static Future<ApiKey?> getActiveKey() async {
    final db = await database;
    final res = await db.query(
      'api_keys',
      where: 'is_active = ?',
      whereArgs: [1],
    );
    if (res.isNotEmpty) {
      return ApiKey.fromMap(res.first);
    }
    return null;
  }

  static Future<List<ApiKey>> getAllKeys() async {
    final db = await database;
    final res = await db.query('api_keys');
    return res.map((e) => ApiKey.fromMap(e)).toList();
  }

  static Future<int> insertKey(ApiKey key) async {
    final db = await database;
    return await db.insert('api_keys', key.toMap());
  }

  static Future<void> updateKey(ApiKey key) async {
    final db = await database;
    await db.update(
      'api_keys',
      key.toMap(),
      where: 'key_id = ?',
      whereArgs: [key.id],
    );
  }

  static Future<void> deleteKey(int id) async {
    final db = await database;
    await db.delete('api_keys', where: 'key_id = ?', whereArgs: [id]);
  }

  static Future<void> activateKey(int id) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('api_keys', {'is_active': 0});
      await txn.update(
        'api_keys',
        {'is_active': 1},
        where: 'key_id = ?',
        whereArgs: [id],
      );
    });
    GeminiService.reset();
  }
}
