import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider provider = DatabaseProvider();
  Database? _database; // DB

  // DB getter
  Future<Database> get database async {
    if (_database != null) return _database!; // If DB exists return DB
    return await initDB(); // If DB does not exist, init new DB
  }

  // Initialize new DB
  initDB() async {
    String path = join(await getDatabasesPath(), 'bibletree_db.db');
    // debugPrint(await getDatabasesPath());

    return await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        database.execute('''CREATE TABLE records (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            verseId INTEGER, 
            like INTEGER DEFAULT 0,
            thought TEXT, 
            createdAt INTEGER)''');
      },
    );
  }
}
