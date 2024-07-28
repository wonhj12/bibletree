import 'package:bibletree/models/record_db.dart';
import 'package:bibletree/models/record_item.dart';

class RecordDao {
  final dbProvider = DatabaseProvider.provider;

  /// Get list of saved RecordItems from database
  Future<List<RecordItem>> getRecordList() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result =
        await db.query('records', orderBy: 'id DESC');
    List<RecordItem> recordList = result.isNotEmpty
        ? result.map((item) => RecordItem.fromDatabaseJson(item)).toList()
        : [];
    return recordList;
  }

  /// Create new RecordItem element and add to database
  Future<int> createRecord(RecordItem record) async {
    final db = await dbProvider.database;
    final result = db.insert('records', record.toDatabaseJson());
    return result;
  }

  /// Update edited RecordItem element into database
  Future<int> updateRecord(RecordItem record) async {
    final db = await dbProvider.database;
    final result = db.update('records', record.toDatabaseJson(),
        where: 'id = ?', whereArgs: [record.id]);
    return result;
  }

  /// Get RecordItem by index
  Future<RecordItem?> getRecordItem(int index) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result =
        await db.query('records', where: 'id = ?', whereArgs: [index + 1]);
    RecordItem? record =
        result.isNotEmpty ? RecordItem.fromDatabaseJson(result.first) : null;
    return record;
  }

  /// Reset database
  Future<void> resetDB() async {
    final db = await dbProvider.database;
    await db.delete('records');
    await db
        .rawUpdate('DELETE FROM sqlite_sequence WHERE name = ?', ['records']);
  }
}
