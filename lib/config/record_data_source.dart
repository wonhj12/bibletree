import 'package:bibletree/models/record_db.dart';
import 'package:flutter/material.dart';

class RecordDataSource {
  final dbProvider = DatabaseProvider.provider;

  /// Get list of saved RecordItems from database
  Future<List<Map<String, dynamic>>> getRecordList() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result = await db.query(
      'records',
      columns: ['id', 'verseId', 'like'],
      orderBy: 'id DESC',
    );
    return result;
  }

  /// Id에 해당하는 Record 불러오기
  Future<Map<String, dynamic>?> getRecordItem(int id) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result =
        await db.query('records', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

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

  /// Reset database
  // Future<void> resetDB() async {
  //   final db = await dbProvider.database;
  //   await db.delete('records');
  //   await db
  //       .rawUpdate('DELETE FROM sqlite_sequence WHERE name = ?', ['records']);
  // }
}
