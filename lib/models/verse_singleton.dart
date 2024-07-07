import 'dart:convert';

import 'package:bibletree/models/verse.dart';
import 'package:flutter/services.dart';

/// Verse list singleton
class VerseSingleton {
  static final VerseSingleton instance = VerseSingleton._internal();
  factory VerseSingleton() => instance;
  VerseSingleton._internal();

  static final List<Verse> _list = [];
  List<Verse> get list => _list;
  set list(List<Verse> value) {
    _list.clear();
    _list.addAll(value);
  }

  Future<List<Verse>> loadVerses() async {
    String jsonString = await rootBundle.loadString('assets/verses.json');
    List<dynamic> verseList = json.decode(jsonString);
    return verseList.map((json) => Verse.fromJson(json)).toList();
  }
}
