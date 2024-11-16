import 'package:bibletree/models/setting_model.dart';
import 'package:bibletree/models/user_model.dart';
import 'package:bibletree/models/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/* 권한 설정 */
/// 사용자 권한 확인하는 함수
void _permissionWithNotification() async {
  if (await Permission.notification.isDenied &&
      !await Permission.notification.isPermanentlyDenied) {
    await [Permission.notification].request();
  }
}

/* 알림 설정 */
final notifications = FlutterLocalNotificationsPlugin();

/// 알림 설정 초기화
void initNotification() async {
  // 알림 권한 확인
  _permissionWithNotification();

  // 안드로이드 설정
  // 아이콘만 설정하면 됨
  AndroidInitializationSettings android =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  // ios 권한 요청
  var iosSetting = const DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  var setting = InitializationSettings(android: android, iOS: iosSetting);
  await notifications.initialize(setting);
}

void setNotification(UserModel userModel, SettingModel settingModel) async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  const androidDetails = AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.defaultPriority,
    importance: Importance.defaultImportance,
  );

  const iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 시간 설정 (아침 9시)
  tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  final schedule = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    userModel.updateTime.hour,
    userModel.updateTime.minute,
  );

  if (settingModel.notification) {
    // 알림 활성화

    // 알림 메시지 설정
    // 묵상을 했으면 다음 말씀 표시, 묵상을 아직 안했으면 묵상할 시간이라고 표시
    final String verse = userModel.recorded
        ? VerseModel.instance.list[userModel.verseId + 1].toString()
        : '돌아와서 오늘의 말씀을 묵상해 보세요.';

    // 알림 id, 제목, 내용 맘대로 채우기
    await notifications.zonedSchedule(
      1,
      '말씀을 묵상할 시간이예요!',
      verse,
      schedule,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    debugPrint('알림 설정: $schedule');
  } else {
    // 알림 설정이 false로 바뀌면 설정된 알림 모두 취소
    notifications.cancelAll();
  }
}
