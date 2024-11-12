import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

void initNotification() async {
  AndroidInitializationSettings android =
      const AndroidInitializationSettings("@mipmap/ic_launcher");

  // ios 권한 요청
  // TODO: permission handler 사용시 false로 설정
  var iosSetting = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings =
      InitializationSettings(android: android, iOS: iosSetting);

  await notifications.initialize(
    initializationSettings,
  );
}

void setNotification() async {
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
  final schedule =
      tz.TZDateTime(tz.local, now.year, now.month, now.day + 1, 9, 0);

  // 알림 id, 제목, 내용 맘대로 채우기
  await notifications.zonedSchedule(
    1,
    '말씀을 묵상할 시간이예요!',
    '돌아와서 오늘의 말씀을 묵상해 보세요.',
    schedule,
    const NotificationDetails(android: androidDetails, iOS: iosDetails),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidScheduleMode: AndroidScheduleMode.exact,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  debugPrint('알림 설정');
}
