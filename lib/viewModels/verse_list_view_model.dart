import 'package:bibletree/config/record_data_source.dart';
import 'package:bibletree/models/record_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerseListViewModel with ChangeNotifier {
  RecordModel recordModel;
  BuildContext context;

  VerseListViewModel({
    required this.recordModel,
    required this.context,
  }) {
    _initialize();
    recordModel.addListener(_onRecordModelChange);
  }

  bool like = false;
  List<Map<String, dynamic>> records = [];

  // 데이터 초기화
  void _initialize() {
    records = recordModel.records;
    notifyListeners();
  }

  void _onRecordModelChange() {
    records = recordModel.records;
    notifyListeners();
  }

  /// 좋아요 버튼 클릭시 호출되는 함수
  void onPressedLike() {
    like = !like;
    records = like
        ? records.where((element) => element['like'] == 1).toList()
        : recordModel.records;

    notifyListeners();
  }

  /// 말씀 카드를 클릭시 호출되는 함수
  ///
  /// 해당하는 Record를 불러온 후 RecordView로 이동
  void onTapVerseListCard(int id) async {
    try {
      final response = await RecordDataSource().getRecordItem(id);
      if (response is Map<String, dynamic>) {
        recordModel.fromJson(response);
      }
    } catch (e) {
      debugPrint('Record 불러오기 실패: $e');
    }

    if (context.mounted) GoRouter.of(context).push('/verse-list/record');
  }
}
