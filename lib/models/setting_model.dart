import 'dart:convert';
import 'package:bibletree/config/local_data_source.dart';
import 'package:flutter/material.dart';

/// ### 앱 설정 데이터를 저장하고 관리하는 클래스
///
/// **설정 관련 변수:**
/// * `Theme theme`
/// * `bool notification`
/// * `bool haptic`
class SettingModel with ChangeNotifier {
  /* 설정 관련 변수 */
  ThemeMode _theme = ThemeMode.system; // 앱 테마 : system, light, dark
  ThemeMode get theme => _theme;
  set theme(ThemeMode newTheme) {
    _theme = newTheme;
    notifyListeners();
  }

  bool notification = true; // 알림 수신 여부
  bool haptic = true; // 햅틱 진동 여부

  SettingModel();

  /// json 데이터를 모델에 저장
  void fromJson(Map<String, dynamic> jsonData) {
    switch (jsonData['theme']) {
      case 'ThemeMode.system':
        theme = ThemeMode.system;
        break;
      case 'ThemeMode.light':
        theme = ThemeMode.light;
        break;
      case 'ThemeMode.dark':
        theme = ThemeMode.dark;
        break;
      default:
        theme = ThemeMode.system;
        break;
    }
    notification = jsonData['notification'];
    haptic = jsonData['haptic'];
  }

  /// 설정 정보 json 변환
  String toJson() {
    return jsonEncode({
      'theme': theme.toString(),
      'notification': notification,
      'haptic': haptic,
    });
  }

  /// 데이터 초기화
  void reset() {
    theme = ThemeMode.system;
    notification = true;
    haptic = true;
  }

  /* 기타 함수 */
  /// 설정을 로컬 저장소에 저장하는 함수
  Future<void> saveSettingModel() async {
    try {
      await LocalDataSource.saveDataToLocal(toJson(), 'setting');
    } catch (e) {
      debugPrint('설정 저장 실패: $e');
    }
  }

  @override
  String toString() {
    return 'theme: $_theme, '
        'notification: $notification, '
        'haptic: $haptic';
  }
}
