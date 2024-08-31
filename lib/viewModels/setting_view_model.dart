import 'package:bibletree/config/local_data_source.dart';
import 'package:bibletree/config/record_data_source.dart';
import 'package:bibletree/model/record_model.dart';
import 'package:bibletree/model/setting_model.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingViewModel with ChangeNotifier {
  UserModel userModel;
  SettingModel settingModel;
  RecordModel recordModel;
  BuildContext context;

  SettingViewModel({
    required this.userModel,
    required this.settingModel,
    required this.recordModel,
    required this.context,
  }) {
    _initialize();
  }

  ThemeMode theme = ThemeMode.system;
  bool notification = true;
  bool haptic = true;

  // 데이터 초기화
  void _initialize() {
    print('a: ${settingModel}');
    theme = settingModel.theme;
    notification = settingModel.notification;
    haptic = settingModel.haptic;

    notifyListeners();
  }

  /// 뒤로가기 버튼 클릭시 호출되는 함수
  void onPressedBackBtn() {
    GoRouter.of(context).pop();
  }

  /// 테마 이름을 반환하는 함수
  String getThemeName() {
    switch (theme) {
      case ThemeMode.light:
        return '라이트 모드';
      case ThemeMode.dark:
        return '다크 모드';
      case ThemeMode.system:
      default:
        return '시스템 설정';
    }
  }

  /// 앱 테마를 변경하는 함수
  void changeTheme(ThemeMode themeMode) async {
    theme = themeMode;
    settingModel.theme = theme;
    await _saveSetting();
    notifyListeners();
  }

  /// 앱 알림 설정을 변경하는 함수
  void changeNotification(bool value) async {
    notification = value;
    settingModel.notification = notification;
    await _saveSetting();
    notifyListeners();
  }

  /// 앱 진동 설정을 변경하는 함수
  void changeHaptic(bool value) async {
    haptic = value;
    settingModel.haptic = haptic;
    await _saveSetting();
    notifyListeners();
  }

  /// 데이터 재설정하는 함수
  void resetData() async {
    try {
      // DB 재설정
      await RecordDataSource().resetDB();

      // 모델 재설정
      userModel.reset();
      settingModel.reset();
      recordModel.reset();

      // 저장된 데이터 삭제
      await LocalDataSource.deleteLocalData('user');
      await LocalDataSource.deleteLocalData('setting');

      notifyListeners();
    } catch (e) {
      debugPrint('데이터 재설정 실패: $e');
    }
  }

  // 설정을 로컬 저장소에 저장하는 함수
  Future<void> _saveSetting() async {
    try {
      await LocalDataSource.saveDataToLocal(settingModel.toJson(), 'setting');
    } catch (e) {
      debugPrint('설정 저장 실패: $e');
    }
  }
}
