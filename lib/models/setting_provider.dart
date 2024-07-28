import 'dart:async';

import 'package:bibletree/bloc/record_bloc.dart';
import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/repositories/record_repository.dart';
import 'package:bibletree/statics/pref_vals.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider with ChangeNotifier {
  SettingProvider() {
    _initialize();
  }

  // Reset data status
  bool reset = false;

  // Shared preferences
  late SharedPreferences _prefs;

  // Initialize saved settings
  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();

    // Set tree name
    treeName = _prefs.getString(PrefVals.treeName);

    // Set theme mode
    switch (_prefs.getString(PrefVals.theme)) {
      case 'system':
        themeMode = ThemeMode.system;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
        break;
    }

    // Set notifications
    notification = _prefs.getBool(PrefVals.noti) ?? true;

    // Set haptics
    haptics = _prefs.getBool(PrefVals.haptic) ?? true;

    notifyListeners();
  }

  /* Tree */
  String? treeName;

  /* Theme */
  ThemeMode themeMode = ThemeMode.system;

  /// Change ThemeMode
  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    _prefs.setString(PrefVals.theme, mode.name);
    notifyListeners();
  }

  /// Return name of theme
  String getThemeName() {
    switch (themeMode) {
      case ThemeMode.light:
        return '라이트 모드';
      case ThemeMode.dark:
        return '다크 모드';
      case ThemeMode.system:
      default:
        return '시스템 설정';
    }
  }

  /* Notifications */
  bool notification = true;

  /// Change the value of notifications setting
  void changeNotification(bool value) {
    notification = value;
    _prefs.setBool(PrefVals.noti, value);
    notifyListeners();
  }

  /* Haptics */
  bool haptics = true;

  /// Change the value of haptics setting
  void changeHaptics(bool value) {
    haptics = value;
    _prefs.setBool(PrefVals.haptic, value);
    notifyListeners();
  }

  /// Reset data
  Future<void> resetData() async {
    final RecordBloc recordBloc = RecordBloc(RecordRepository(RecordDao()));

    // Reset shared prefs
    await _prefs.remove(PrefVals.canWater);
    await _prefs.remove(PrefVals.firstLogin);
    await _prefs.remove(PrefVals.growth);
    await _prefs.remove(PrefVals.haptic);
    await _prefs.remove(PrefVals.lastLogin);
    await _prefs.remove(PrefVals.noti);
    await _prefs.remove(PrefVals.theme);
    await _prefs.remove(PrefVals.todayId);
    await _prefs.remove(PrefVals.treeName);

    // Reset db
    await recordBloc.resetDB();

    reset = true;
  }
}
