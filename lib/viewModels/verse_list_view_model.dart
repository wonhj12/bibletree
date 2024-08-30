import 'package:bibletree/model/record_model.dart';
import 'package:flutter/material.dart';

class VerseListViewModel with ChangeNotifier {
  RecordModel recordModel;
  BuildContext context;

  VerseListViewModel({
    required this.recordModel,
    required this.context,
  }) {
    _initialize();
  }

  bool like = false;
  List<Map<String, dynamic>> records = [];

  void _initialize() {
    records = recordModel.records ?? [];
  }

  void onPressedLike() {
    like = !like;
    notifyListeners();
  }
}
