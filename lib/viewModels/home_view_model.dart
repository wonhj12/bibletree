import 'package:bibletree/config/local_data_source.dart';
import 'package:bibletree/config/record_data_source.dart';
import 'package:bibletree/model/record_model.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:bibletree/widgets/name_alert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel with ChangeNotifier {
  UserModel userModel;
  RecordModel recordModel;
  BuildContext context;

  HomeViewModel({
    required this.userModel,
    required this.recordModel,
    required this.context,
  }) {
    _initialize();
  }

  bool canWater = false;
  int growth = 0;

  // 나무 이름 관련
  String? treeName;
  String? nameErrorText;
  TextEditingController nameController = TextEditingController();

  // 데이터 초기화
  void _initialize() {
    treeName = userModel.treeName;
    canWater = userModel.canWater;
    growth = userModel.growth;
  }

  /// 설정 버튼 클릭시 호출되는 함수
  void onPressedSetting() async {
    await GoRouter.of(context).push('/home/setting');
    notifyListeners();
  }

  /// 말씀 카드 클릭시 호출되는 함수
  void onTapVerseCard() async {
    try {
      final response =
          await RecordDataSource().getRecordItem(userModel.verseId + 1);
      if (response is Map<String, dynamic>) {
        recordModel.fromJson(response);
      }
    } catch (e) {
      debugPrint('Record 불러오기 실패: $e');
    }

    if (context.mounted) {
      final isNewRecord = await GoRouter.of(context).push('/home/record');
      if (isNewRecord is bool && isNewRecord) {
        canWater = true; // 새로 Record를 추가했을 때에만 true로 설정
        userModel.canWater = true;

        await _saveUserModel();
      }
      notifyListeners();
    }
  }

  /// 나무에 물 줄 때 호출되는 함수
  /// * growth를 1 증가시키고 canWater을 false로 설정한다
  /// * 나무 이름을 아직 설정하지 않았다면 이름 입력 dialog를 띄운다
  void onTapWater() async {
    growth += 1;
    canWater = false;

    // 나무 물주기 페이지 이동
    final needName = await GoRouter.of(context).push('/home/water');

    // 나무 이름이 아직 정해지지 않았다면 dialog 호출 후 이름 지정
    if (userModel.treeName == null && needName is bool && needName) {
      if (context.mounted) {
        // 이름 입력 팝업
        await showNameDialog(
          context,
          nameController,
        );

        treeName = nameController.text;
        userModel.treeName = treeName;
        _saveUserModel();
      }
      // if (context.mounted) {
      //   String? name = '';

      //   // 이름 입력 팝업

      //   if (/* name != null && */ name.isNotEmpty) {
      //     userModel.treeName = name;
      //   }
      // }
    }

    notifyListeners();

    // 데이터 저장
    userModel.growth = growth;
    userModel.canWater = canWater;

    await _saveUserModel();
  }

  /// 사용자 데이터를 로컬 저장소에 저장하는 함수
  Future<void> _saveUserModel() async {
    try {
      LocalDataSource.saveDataToLocal(userModel.toJson(), 'user');
    } catch (e) {
      debugPrint('사용자 데이터 저장 실패: $e');
    }
  }
}
