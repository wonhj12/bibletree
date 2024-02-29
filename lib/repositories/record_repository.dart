import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/models/record_item.dart';

class RecordRepository {
  final RecordDao _recordDao;
  RecordRepository(this._recordDao);

  Future<List<RecordItem>> getRecordList() => _recordDao.getRecordList();

  Future<int> createRecord(RecordItem record) =>
      _recordDao.createRecord(record);

  Future<int> updateRecord(RecordItem record) =>
      _recordDao.updateRecord(record);
}
