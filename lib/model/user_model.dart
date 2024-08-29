import 'package:flutter/material.dart';

// enum Theme { system, light, dark }

/// ### 사용자 데이터를 저장하고 관리하는 클래스
/// 설정, 나무에 관련된 변수 및 함수를 담당
///
/// **설정 관련 변수:**
/// * `Theme theme`
/// * `bool notification`
/// * `bool haptic`
///
/// **나무 관련 변수:**
/// * `String? treeName`
/// * `int growth`
///
/// **말씀 관련 변수**
/// * `int verseId`
/// * `String? book`
/// * `String? chapter`
/// * `String? verse`
class UserModel with ChangeNotifier {
  /* 설정 관련 변수 */
  ThemeMode theme = ThemeMode.system; // 앱 테마 : system, light, dark
  bool notification = true; // 알림 수신 여부
  bool haptic = true; // 햅틱 진동 여부

  /* 나무 관련 변수 */
  String? treeName; // 나무 이름
  int growth = 0; // 나무 성장 수치

  /* 말씀 관련 변수 */
  int verseId = 0; // 오늘의 말씀 id
  String? book; // 책
  String? chapter; // 장
  String? verse; // 절

  /* 기타 사용자 관련 변수 */
  bool isFirstTimeLogin = false;

  UserModel({
    this.treeName,
  });
}
