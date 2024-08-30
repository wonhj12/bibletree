import 'package:bibletree/models/record_db.dart';
import 'package:flutter/material.dart';

class RecordDataSource {
  final dbProvider = DatabaseProvider.provider;

  /// Get list of saved RecordItems from database
  // Future<List<RecordItem>> getRecordList() async {
  //   final db = await dbProvider.database;
  //   List<Map<String, dynamic>> result =
  //       await db.query('records', orderBy: 'id DESC');
  //   List<RecordItem> recordList = result.isNotEmpty
  //       ? result.map((item) => RecordItem.fromDatabaseJson(item)).toList()
  //       : [];
  //   return recordList;
  // }

  /// 신규 데이터 추가
  Future<int> createRecord(Map<String, dynamic> jsonData) async {
    try {
      final db = await dbProvider.database;
      final result = db.insert('records', jsonData);
      return result;
    } catch (e) {
      debugPrint('createRecord 실패: $e');
      throw ErrorDescription('createRecord failed');
    }
  }

  /// 데이터 업데이트
  Future<int> updateRecord(Map<String, dynamic> jsonData) async {
    try {
      final db = await dbProvider.database;
      final result = db.update(
        'records',
        jsonData,
        where: 'id = ?',
        whereArgs: [jsonData['id']],
      );
      return result;
    } catch (e) {
      debugPrint('updateRecord 실패: $e');
      throw ErrorDescription('updateRecord failed');
    }
  }

  /// Get RecordItem by index
  Future<Map<String, dynamic>?> getRecordItem(int index) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result =
        await db.query('records', where: 'id = ?', whereArgs: [index + 1]);
    return result.isNotEmpty ? result.first : null;
  }

  /// Reset database
  // Future<void> resetDB() async {
  //   final db = await dbProvider.database;
  //   await db.delete('records');
  //   await db
  //       .rawUpdate('DELETE FROM sqlite_sequence WHERE name = ?', ['records']);
  // }
}
