import 'dart:convert';
import 'package:bibletree/config/local_data_source.dart';
import 'package:bibletree/models/verse_model.dart';
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
/// * `Verse? todayVerse`
///
/// **기타 사용자 관련 변수**
/// * `TimeOfDay updateTime`
/// * `int? lastLogin`
class UserModel with ChangeNotifier {
  /* 나무 관련 변수 */
  String? treeName; // 나무 이름
  int growth = 0; // 나무 성장 수치
  bool canWater = false; // 물 주기 가능 여부

  /* 말씀 관련 변수 */
  int verseId = 0; // 오늘의 말씀 id
  Verse? todayVerse; // 오늘의 말씀

  /* 기타 사용자 관련 변수 */
  TimeOfDay updateTime = const TimeOfDay(hour: 9, minute: 0); // 말씀 업데이트 시간
  int lastLogin = DateTime.now().millisecondsSinceEpoch; // 마지막 로그인 시점
  bool recorded = false; // 전날 묵상 기록 여부

  UserModel({this.treeName, this.todayVerse});

  /// json 데이터를 모델에 저장
  void fromJson(Map<String, dynamic> jsonData) {
    treeName = jsonData['treeName'];
    growth = jsonData['growth'] ?? 0;
    canWater = jsonData['canWater'] ?? false;
    verseId = jsonData['verseId'] ?? 0;
    updateTime = _stringToTimeOfDay(jsonData['updateTime'] ?? '');
    lastLogin = jsonData['lastLogin'] ?? DateTime.now().millisecondsSinceEpoch;
    recorded = jsonData['recorded'] ?? false;
  }

  /// 사용자 정보 json 변환
  String toJson() {
    return jsonEncode({
      'treeName': treeName,
      'growth': growth,
      'canWater': canWater,
      'verseId': verseId,
      'updateTime': _timeOfDayToString(updateTime),
      'lastLogin': lastLogin,
      'recorded': recorded,
    });
  }

  /// 데이터 초기화
  void reset() {
    treeName = null;
    growth = 0;
    canWater = false;
    verseId = 0;
    todayVerse = null;
    getTodayVerse(); // 오늘 verse 불러오기
    lastLogin = DateTime.now().millisecondsSinceEpoch;
    recorded = false;
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

  /* 말씀 관련 함수 */
  /// VerseModel에서 오늘의 Verse를 가져오는 함수
  void getTodayVerse() {
    todayVerse = VerseModel.instance.list[verseId];
  }

  /* 기타 함수 */
  /// `String` 형태의 시간 정보를 `TimeOfDay`로 반환하는 함수
  /// <br /> Default: 09:00
  TimeOfDay _stringToTimeOfDay(String time) {
    if (time.isNotEmpty && time.contains(':')) {
      List<String> parts = time.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    }

    // 기본값 9:00 AM
    return const TimeOfDay(hour: 9, minute: 0);
  }

  /// `TimeOfDay` 형태의 시간 정보를 `String`으로 변환하는 함수
  String _timeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  /// 사용자 데이터를 로컬 저장소에 저장하는 함수
  Future<void> saveUserModel() async {
    try {
      LocalDataSource.saveDataToLocal(toJson(), 'user');
    } catch (e) {
      debugPrint('사용자 데이터 저장 실패: $e');
    }
  }

  @override
  String toString() {
    return 'treeName: $treeName, '
        'growth: $growth, '
        'canWater: $canWater, '
        'verseId: $verseId, '
        'updateTime: ${_timeOfDayToString(updateTime)}, '
        'lastLogin: $lastLogin, '
        'recorded: $recorded';
  }
}
