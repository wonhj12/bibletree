import 'package:bibletree/config/app_router.dart';
import 'package:bibletree/config/local_data_source.dart';
import 'package:bibletree/config/notifications.dart';
import 'package:bibletree/config/record_data_source.dart';
import 'package:bibletree/models/record_model.dart';
import 'package:bibletree/models/setting_model.dart';
import 'package:bibletree/models/user_model.dart';
import 'package:bibletree/config/custom_theme_data.dart';
import 'package:bibletree/models/verse_model.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  VerseModel.instance; // 말씀 데이터 로딩
  await initializeData();
  initNotification();

  runApp(const BibleTreeApp());
}

/// 사용자, 설정, Record 데이터 불러오기 및 초기화
Future<void> initializeData() async {
  try {
    /* 데이터 불러오기 */
    // Record 데이터 불러오기
    dynamic recordResponse = await RecordDataSource().getRecordList();
    if (recordResponse is List<Map<String, dynamic>>) {
      recordModel.records = recordResponse;
    }
    debugPrint('Initialized records');

    // 저장된 유저 데이터 불러오기
    dynamic userResponse = await LocalDataSource.getLocalData('user');
    if (userResponse is Map<String, dynamic>) {
      // 유저 정보가 존재한다면 데이터 불러오기
      userModel.fromJson(userResponse);

      // 사용자 초기화
      await initUser();
    }
    debugPrint('Initialized user');

    // 저장된 설정 데이터 불러오기
    dynamic settingResponse = await LocalDataSource.getLocalData('setting');
    if (settingResponse is Map<String, dynamic>) {
      // 설정 정보가 존재한다면 데이터 불러오기
      settingModel.fromJson(settingResponse);
    } else {
      // 아직 설정이 없는 상태라면 알림 끄기 설정을 하지 않은 상태이기 때문에 자동으로 알람 켬
      // 설정을 저장한 상태라면 거기서 알아서 진행하게 됨
      setNotification();
    }
    debugPrint('Initialized setting');

    // 초기화 완료 후 로그인 시간 및 수정된 데이터 업데이트
    userModel.lastLogin = DateTime.now().millisecondsSinceEpoch;
    await userModel.saveUserModel();
  } catch (e) {
    debugPrint('Failed to initialize data: $e');
  }
}

/// 사용자 데이터 초기화
Future<void> initUser() async {
  final now = DateTime.now();
  final updateTime = DateTime(now.year, now.month, now.day,
      userModel.updateTime.hour, userModel.updateTime.minute);
  final lastLogin = DateTime.fromMillisecondsSinceEpoch(userModel.lastLogin);
  // if (!DateUtils.isSameDay(lastLogin, DateTime.now())) {
  //   userModel.verseId += 1;
  // }
  // 마지막 로그인 시점이 오늘 updateTime 이전일 경우에만 진행
  if (lastLogin.isBefore(updateTime)) {
    // updateTime이 지났고 기록이 있으면 verseId 업데이트
    if (now.isAfter(updateTime) && userModel.recorded) {
      userModel.verseId += 1;
      userModel.recorded = false;
    }
  }

  // 오늘 말씀 설정
  userModel.getTodayVerse();
}

// Models
UserModel userModel = UserModel();
RecordModel recordModel = RecordModel();
SettingModel settingModel = SettingModel();

// 라우터
final _router = AppRouter.getRouter(userModel, recordModel, settingModel);

class BibleTreeApp extends StatefulWidget {
  const BibleTreeApp({super.key});

  @override
  State<BibleTreeApp> createState() => _BibleTreeAppState();
}

class _BibleTreeAppState extends State<BibleTreeApp> {
  @override
  Widget build(BuildContext context) {
    ThemeMode theme = settingModel.theme;

    // 테마 변경을 위한 listener
    settingModel.addListener(
      () => setState(() {
        theme = settingModel.theme;
      }),
    );

    return MaterialApp.router(
      theme: CustomThemeData.light,
      darkTheme: CustomThemeData.dark,
      themeMode: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
