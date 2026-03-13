import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB('items.db');

    return _database!;

  }

  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: (Database db, oldVersion, newVersion) async {
        // await db.execute('DROP TABLE IF EXISTS items');
        // await _createDB(db, newVersion);
      }
    );
  }

  Future _createDB(Database db, int version) async {
    await createItemTable(db);
    await createSessionTable(db);
  }


  static Future<void> createItemTable(Database database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT, total_price REAL, price REAL, quantity REAL, session_id TEXT)');
  }

  static Future<void> createSessionTable(Database database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS grocery_session (id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT, date DATE, total_price REAL, total_item INTEGER, session_id TEXT)');
  }

}