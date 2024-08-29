import 'package:bibletree/model/record_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecordViewModel with ChangeNotifier {
  RecordModel recordModel;
  BuildContext context;

  RecordViewModel({required this.recordModel, required this.context}) {
    _initialize();
  }

  bool like = false;
  String thought = '';

  // 데이터 초기화
  void _initialize() {
    like = recordModel.like ?? false;
  }

  /// 좋아요 버튼 클릭시 호출되는 함수
  void onPressedLike() {
    like = !like;
    notifyListeners();
  }

  /// 저장 버튼 클릭시 호출되는 함수
  void onPressedSave() {
    context.pop();
  }

  /// 느낀점 입력시 호출되는 함수
  void onTextChanged(String text) {
    thought = text;
    notifyListeners();
  }
}
