import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataSource {
  /// 데이를 로컬 저장소에 저장하는 함수
  /// * **user** : 사용자 데이터
  /// * **setting** : 설정 데이터
  static Future<dynamic> saveDataToLocal(String jsonData, String target) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$target.json');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      dynamic response = await file.writeAsString(jsonData);
      debugPrint('$target 데이터 저장');
      return response;
    } catch (e) {
      debugPrint('saveDataToLocal 실패: $e');
      throw ErrorDescription('saveDataToLocal failed');
    }
  }

  /// 로컬 저장소에 저장된 데이터를 불러오는 함수
  /// * **user** : 사용자 데이터
  /// * **setting** : 설정 데이터
  static Future<dynamic> getLocalData(String target) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$target.json');

      if (await file.exists()) {
        final response = await file.readAsString();
        return jsonDecode(response);
      } else {
        debugPrint('$target 데이터 없음');
        return;
      }
    } catch (e) {
      debugPrint('getLocalData failed: $e');
      throw ErrorDescription('getLocalData failed');
    }
  }

  /// 로컬 저장소에 저장된 데이터를 삭제하는 함수
  /// * **user** : 사용자 데이터
  /// * **setting** : 설정 데이터
  static Future<void> deleteLocalData(String target) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$target.json');

      if (await file.exists()) {
        await file.delete();
        debugPrint('$target 삭제');
      } else {
        debugPrint('$target 데이터 없음');
      }
    } catch (e) {
      debugPrint('deleteLocalData failed: $e');
      throw ErrorDescription('deleteLocalData failed');
    }
  }
}
