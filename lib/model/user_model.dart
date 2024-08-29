import 'dart:convert';

import 'package:flutter/material.dart';

/// ### 사용자 데이터를 저장하고 관리하는 클래스
/// 사용자, 나무에 관련된 변수 및 함수를 담당
///
/// **나무 관련 변수:**
/// * `String? treeName`
/// * `int growth`
/// * `bool canWater`
///
/// **말씀 관련 변수**
/// * `int verseId`
/// * `String? book`
/// * `String? chapter`
/// * `String? verse`
///
/// **기타 사용자 관련 변수**
/// * `int? lastLogin`
class UserModel with ChangeNotifier {
  /* 나무 관련 변수 */
  String? treeName; // 나무 이름
  int growth = 0; // 나무 성장 수치
  bool canWater = false; // 물 주기 가능 여부

  /* 말씀 관련 변수 */
  int verseId = 0; // 오늘의 말씀 id
  String? book; // 책
  String? chapter; // 장
  String? verse; // 절

  /* 기타 사용자 관련 변수 */
  int? lastLogin; // 마지막 로그인 시점

  UserModel({
    this.treeName,
    this.book,
    this.chapter,
    this.verse,
    this.lastLogin,
  });

  /// json 데이터를 모델에 저장
  void fromJson(Map<String, dynamic> jsonData) {
    treeName = jsonData['treeName'];
    growth = jsonData['growth'];
    canWater = jsonData['canWater'];
    verseId = jsonData['verseId'];
    lastLogin = jsonData['lastLogin'];
  }

  /// 사용자 정보 json 변환
  String toJson() {
    return jsonEncode({
      'treeName': treeName,
      'growth': growth,
      'canWater': canWater,
      'verseId': verseId,
      'lastLogin': lastLogin,
    });
  }

  @override
  String toString() {
    return 'treeName: $treeName, '
        'growth: $growth, '
        'canWater: $canWater, '
        'verseId: $verseId, '
        'lastLogin: $lastLogin';
  }
}
