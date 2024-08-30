import 'package:flutter/material.dart';

/// ### Record 데이터를 저장하고 관리하는 클래스
/// Record, 말씀과 관련된 변수 및 함수를 담당
///
/// **현재 Record 관련 변수**
/// * `int? id`
/// * `int? verseId`
/// * `bool? like`
/// * `String? thought`
/// * `DateTime? createdAt`
class RecordModel with ChangeNotifier {
  /* 현재 선택된 Record 정보 */
  int? id; // Record id
  int? verseId; // 말씀 id
  bool? like; // 좋아요 여부
  String? thought; // 느낀 점
  DateTime? createdAt; // 등록 날짜

  RecordModel({
    this.id,
    this.verseId,
    this.like,
    this.thought,
    this.createdAt,
  });

  void fromJson(Map<String, dynamic> jsonData) {
    reset();

    id = jsonData['id'];
    verseId = jsonData['verseId'];
    like = jsonData['like'] == 1;
    thought = jsonData['thought'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(jsonData['createdAt']);
  }

  /// DB에 저장하기 위한 json 변환
  ///
  /// verseId, like, thought, createdAt
  Map<String, dynamic> toJsonDatabase() {
    if (verseId == null || like == null || createdAt == null) {
      throw ErrorDescription('incomplete data');
    }

    return {
      'id': id,
      'verseId': verseId,
      'like': like! ? 1 : 0,
      'thought': thought,
      'createdAt': createdAt!.millisecondsSinceEpoch
    };
  }

  /// 데이터 초기화
  void reset() {
    id = null;
    verseId = null;
    like = null;
    thought = null;
    createdAt = null;
  }

  @override
  String toString() {
    return 'id: $id, '
        'verseId: $verseId, '
        'like: $like, '
        'thought: $thought, '
        'createdAt: $createdAt';
  }
}
