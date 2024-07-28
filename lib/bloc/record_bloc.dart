import 'dart:async';

import 'package:bibletree/repositories/record_repository.dart';
import 'package:bibletree/models/record_item.dart';

class RecordBloc {
  final RecordRepository _recordRepository;
  final StreamController<List<RecordItem>> _recordController =
      StreamController<List<RecordItem>>.broadcast();

  get recordListStream => _recordController.stream;

  RecordBloc(this._recordRepository) {
    getRecordList();
  }

  /// Get list of saved RecordItems from database
  void getRecordList() async {
    List<RecordItem> recordList = await _recordRepository.getRecordList();
    _recordController.sink.add(recordList);
  }

  /// Create new RecordItem element and add to database
  void createRecord(RecordItem record) async {
    await _recordRepository.createRecord(record);
  }

  /// Update edited RecordItem element into database
  void updateRecord(RecordItem record) async {
    await _recordRepository.updateRecord(record);
  }

  /// Reset database
  Future<void> resetDB() async {
    await _recordRepository.resetDB();
  }
}
