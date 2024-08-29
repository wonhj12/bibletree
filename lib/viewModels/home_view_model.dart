import 'package:bibletree/config/local_data_source.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;

  HomeViewModel({required this.userModel, required this.context}) {
    _initialize();
  }

  bool canWater = false;
  int growth = 0;

  // 데이터 초기화
  void _initialize() {
    canWater = userModel.canWater;
    growth = userModel.growth;
  }

  /// 설정 버튼 클릭시 호출되는 함수
  void onPressedSetting() async {
    await GoRouter.of(context).push('');
    notifyListeners();
  }

  /// 말씀 카드 클릭시 호출되는 함수
  void onTapVerseCard() async {
    await GoRouter.of(context).push('');
  }

  /// 나무에 물 줄 때 호출되는 함수
  /// * growth를 1 증가시키고 canWater을 false로 설정한다
  /// * 나무 이름을 아직 설정하지 않았다면 이름 입력 dialog를 띄운다
  void water() async {
    growth += 1;
    canWater = false;

    // 나무 물주기 페이지 이동
    await GoRouter.of(context).push('');

    // 나무 이름이 아직 정해지지 않았다면 dialog 호출 후 이름 지정
    if (userModel.treeName == null) {
      if (context.mounted) {
        String? name = '';

        if (name != null && name.isNotEmpty) {
          userModel.treeName = name;
        }
      }
    }

    // 데이터 저장
    userModel.growth = growth;
    userModel.canWater = canWater;

    LocalDataSource.saveDataToLocal(userModel.toJson(), 'user');
  }
}
