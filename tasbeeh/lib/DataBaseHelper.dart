import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasbeehat.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE tasbeehat(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tasbeeh TEXT,
            maxCount INTEGER,
            totalCycles INTEGER,
            currentCount INTEGER
          )
          ''',
        );
      },
    );
  }

  Future<int> insertTasbeeh(Map<String, dynamic> tasbeeh) async {
    final db = await database;
    return await db.insert('tasbeehat', tasbeeh);
  }

  Future<List<Map<String, dynamic>>> getTasbeehat() async {
    final db = await database;
    return await db.query('tasbeehat');
  }

  Future<int> updateTasbeeh(int id, Map<String, dynamic> tasbeeh) async {
    final db = await database;
    return await db.update(
      'tasbeehat',
      tasbeeh,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTasbeeh(int id) async {
    final db = await database;
    return await db.delete(
      'tasbeehat',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
