import 'package:flutter/material.dart';

/// ### Record 데이터를 저장하고 관리하는 클래스
/// Record, 말씀과 관련된 변수 및 함수를 담당
///
/// **현재 Record 관련 변수**
/// * `int? id`
/// * `bool? like`
/// * `String? thought`
/// * `DateTime? createdAt`
///
/// **현재 말씀 관련 변수**
/// * `int? verseId`
/// * `String? book`
/// * `String? chapter`
/// * `String? verse`
class RecordModel with ChangeNotifier {
  /* 현재 선택된 Record 정보 */
  int? recordId; // Record id
  bool? like; // 좋아요 여부
  String? thought; // 느낀 점
  DateTime? createdAt; // 등록 날짜

  /* 현재 선택된 말씀 정보 */
  int? verseId; // 말씀 id
  String? book; // 책
  String? chapter; // 장
  String? verse; // 절

  RecordModel({
    this.recordId,
    this.like,
    this.thought,
    this.createdAt,
    this.verseId,
  });
}
