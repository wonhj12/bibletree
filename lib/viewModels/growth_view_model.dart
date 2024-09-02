import 'package:bibletree/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GrowthViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;

  GrowthViewModel({required this.userModel, required this.context}) {
    _initialize();
  }

  /* 물주기 관련 함수 */
  int count = 3; // 물 주기 위한 탭 수
  bool isShaking = false; // 흔들림 효과 진행 여부

  final int shakeDuration = 200; // 흔들림 효과 지속 시간 milliseconds
  final double shakeWidth = 15; // 흔들림 크기

  /* 나무 관련 변수 */
  String treeName = '나무';
  int growth = 0;
  bool needName = false;
  final _growthLevel = 10;

  // 데이터 초기화
  void _initialize() {
    print('1');
    treeName = userModel.treeName ?? '나무';
    growth = userModel.growth;
  }

  /// 나무 물주기 때 표시할 메세지를 반환하는 함수
  ///
  /// 현재 `growth` 값과 `growthLevel`에 의해서 결정됨
  String treeDescription() {
    int level = growth % _growthLevel == 0 ? growth ~/ _growthLevel : -1;
    switch (level) {
      case 0:
        return '새로운 생명이네요! 어떤 나무로 자라게 될까요?';
      case 1:
        needName = true;
        return '새싹이 인사하네요! 이름을 지어 줄까요?';
      case 2:
        return '$treeName(이)의 줄기가 자랐네요!';
      case 3:
        return '$treeName(이)의 잎이 활짝 폈어요!';
      case 4:
        return '$treeName(이)에게 꽃봉우리가 생겼네요!';
      case 5:
        return '$treeName(이)가 예쁜 꽃을 활짝 폈어요';
      case 6:
        return '$treeName(이)가 상수리 나무로 자랐어요!';
      // if (_tree == 0) {
      //   return '$treeName(이)가 상수리 나무로 자랐어요!';
      // } else if (_tree == 1) {
      //   return '$treeName(이)가 백향목으로 자랐어요!';
      // } else {
      //   return '$name(이)가 올리브 나무로 자랐어요!';
      // }
      default:
        return '나무를 탭해서 물을 주세요!';
    }
  }

  /// 나무 탭했을 때 호출되는 함수
  ///
  /// 흔들림 효과 실행
  void onTapTree() async {
    if (count > 0) {
      count -= 1;
      isShaking = true;
      notifyListeners();

      Future.delayed(
        Duration(milliseconds: shakeDuration),
        () => isShaking = false,
      );

      if (count == 0) {
        await Future.delayed(Duration(milliseconds: shakeDuration));
        if (context.mounted) context.pop(needName);
      }
    }
  }
}
