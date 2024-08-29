import 'package:flutter/material.dart';

/// ### 앱 설정 데이터를 저장하고 관리하는 클래스
///
/// **설정 관련 변수:**
/// * `Theme theme`
/// * `bool notification`
/// * `bool haptic`
class SettingModel with ChangeNotifier {
  /* 설정 관련 변수 */
  ThemeMode theme = ThemeMode.system; // 앱 테마 : system, light, dark
  bool notification = true; // 알림 수신 여부
  bool haptic = true; // 햅틱 진동 여부

  SettingModel();
}
