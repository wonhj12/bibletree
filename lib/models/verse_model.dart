import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 말씀 데이터를 가지고 있는 singleton
///
/// * `VerseModel.list`로 말씀 리스트 접근
class VerseModel {
  static final VerseModel instance = VerseModel._internal();
  factory VerseModel() => instance;
  VerseModel._internal() {
    _initialize();
  }

  void _initialize() async {
    list = await loadVerses();
    debugPrint('Initialized VerseModel - loaded ${list.length} verses');
  }

  static final List<Verse> _list = [];
  List<Verse> get list => _list;
  set list(List<Verse> value) {
    _list.clear();
    _list.addAll(value);
  }

  /// verses.json 파일에서 말씀 데이터를 불러오는 함수
  Future<List<Verse>> loadVerses() async {
    String jsonString = await rootBundle.loadString('assets/verses.json');
    List<dynamic> verseList = json.decode(jsonString);
    return verseList.map((json) => Verse.fromJson(json)).toList();
  }
}

/// Verse 자료 구조
/// * `int id`
/// * `String verse`
/// * `String book`
/// * `String chapter`
class Verse {
  int id;
  String verse;
  String book;
  String chapter;

  Verse({
    required this.id,
    required this.verse,
    required this.book,
    required this.chapter,
  });

  /// json 데이터를 Verse 구조로 변경
  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json['id'] as int,
        verse: json['verse'],
        book: json['book'],
        chapter: json['chapter'],
      );

  @override
  String toString() {
    return '$verse ($book $chapter)';
  }
}
