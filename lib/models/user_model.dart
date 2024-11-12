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

  /* 기타 사용자 관련 변수 */
  int lastLogin = DateTime.now().millisecondsSinceEpoch; // 마지막 로그인 시점

  UserModel({this.treeName});

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

  /* 나무 관련 함수 */
  final int _growthLevel = 10; // 나무 성장 10마다 다음 단계로 성장

  /// 현재 나무 이미지 이름 반환
  String getCurTree() {
    final level = growth ~/ _growthLevel;

    switch (level) {
      case 0:
        return 'seed1.png';
      case 1:
        return 'seed2.png';
      case 2:
        return 'plant1.png';
      case 3:
        return 'plant2.png';
      case 4:
        return 'plant3.png';
      case 5:
        return 'plant4.png';
      case 6:
        return 'tree1.png';
      default:
        return 'seed1.png';
    }
  }

  /// 데이터 초기화
  void reset() {
    treeName = null;
    growth = 0;
    canWater = false;
    verseId = 0;
    lastLogin = DateTime.now().millisecondsSinceEpoch;
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
