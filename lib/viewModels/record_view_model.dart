import 'package:bibletree/config/notifications.dart';
import 'package:bibletree/config/record_data_source.dart';
import 'package:bibletree/models/record_model.dart';
import 'package:bibletree/models/setting_model.dart';
import 'package:bibletree/models/user_model.dart';
import 'package:bibletree/models/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecordViewModel with ChangeNotifier {
  UserModel userModel;
  RecordModel recordModel;
  SettingModel settingModel;
  BuildContext context;

  RecordViewModel({
    required this.userModel,
    required this.recordModel,
    required this.settingModel,
    required this.context,
  }) {
    _initialize();
  }

  bool like = false;
  String? thought;
  String? _initThought; // 느낀점 수정 여부 확인을 위한 변수

  late Verse verse;

  // 데이터 초기화
  void _initialize() {
    like = recordModel.like ?? false;
    _initThought = thought;

    verse = VerseModel.instance.list[recordModel.verseId!];
  }

  /// 좋아요 버튼 클릭시 호출되는 함수
  void onPressedLike() async {
    like = !like;
    recordModel.like = like;

    // 수정 모드일 때 바로 DB 업데이트
    if (recordModel.id != null) {
      try {
        await RecordDataSource().updateRecord(recordModel.toJsonDatabase());
        recordModel.updateLike();
      } catch (e) {
        debugPrint('저장 실패: $e');
      }
    }

    notifyListeners();
  }

  /// 저장 버튼 클릭시 호출되는 함수
  void onPressedSave() async {
    try {
      final isNewRecord = recordModel.id == null;

      recordModel.thought = thought;

      if (isNewRecord) {
        // 신규 Record 생성
        recordModel.verseId = userModel.verseId;
        recordModel.like = like;
        recordModel.createdAt = DateTime.now();
        final id =
            await RecordDataSource().createRecord(recordModel.toJsonDatabase());
        recordModel.addRecord(id);
        userModel.recorded = true; // 신규 묵상 저장시 기록 여부 true 설정
        setNotification(userModel, settingModel); // 다음 말씀으로 알람 새로 설정
      } else {
        // Record 수정
        if (thought != _initThought) {
          await RecordDataSource().updateRecord(recordModel.toJsonDatabase());
        }
      }

      if (context.mounted) context.pop(isNewRecord);
    } catch (e) {
      debugPrint('저장 실패: $e');
    }
  }

  /// 느낀점 입력시 호출되는 함수
  void onTextChanged(String text) {
    thought = text;
    notifyListeners();
  }
}
