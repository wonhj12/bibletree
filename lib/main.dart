import 'package:bibletree/config/app_router.dart';
import 'package:bibletree/config/local_data_source.dart';
import 'package:bibletree/config/record_data_source.dart';
import 'package:bibletree/model/record_model.dart';
import 'package:bibletree/model/setting_model.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:bibletree/statics/custom_theme_data.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeData();
  // // Initialize singletons
  // VerseSingleton.instance;

  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => SettingProvider(),
  //     child: const MainApp(),
  //   ),
  // );

  runApp(const BibleTreeApp());
}

/// 사용자, 설정 데이터 불러오기 및 초기화
Future<void> initializeData() async {
  try {
    // 저장된 유저 데이터 불러오기
    dynamic userResponse = await LocalDataSource.getLocalData('user');

    if (userResponse is Map<String, dynamic>) {
      // 유저 정보가 존재한다면 데이터 불러오기
      userModel.fromJson(userResponse);
      await initUser();
    }

    // 저장된 설정 데이터 불러오기
    dynamic settingResponse = await LocalDataSource.getLocalData('setting');

    if (settingResponse is Map<String, dynamic>) {
      // 유저 정보가 존재한다면 데이터 불러오기
      settingModel.fromJson(settingResponse);
    }

    dynamic recordResponse = await RecordDataSource().getRecordList();

    if (recordResponse is List<Map<String, dynamic>>) {
      recordModel.records = recordResponse;
    }

    // 초기화 완료 후 로그인 시간 및 수정된 데이터 업데이트
    userModel.lastLogin = DateTime.now().millisecondsSinceEpoch;
    await LocalDataSource.saveDataToLocal(userModel.toJson(), 'user');
  } catch (e) {
    debugPrint('Failed to initialize data: $e');
  }
}

/// 사용자 데이터 초기화
Future<void> initUser() async {
  final lastLogin = DateTime.fromMillisecondsSinceEpoch(userModel.lastLogin!);
  if (!DateUtils.isSameDay(lastLogin, DateTime.now())) {
    userModel.verseId += 1;
  }
}

// Models
UserModel userModel = UserModel();
RecordModel recordModel = RecordModel();
SettingModel settingModel = SettingModel();

// 라우터
final _router = AppRouter.getRouter(userModel, recordModel, settingModel);

class BibleTreeApp extends StatelessWidget {
  const BibleTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: CustomThemeData.light,
      darkTheme: CustomThemeData.dark,
      themeMode: settingModel.theme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: CustomThemeData.light,
  //     darkTheme: CustomThemeData.dark,
  //     themeMode: Provider.of<SettingProvider>(context).themeMode,
  //     home: FutureBuilder(
  //       // Initialize verse before loading screen
  //       future: VerseSingleton.instance.loadVerses(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           VerseSingleton.instance.list = snapshot.data!;
  //           return PageView(
  //             physics: const ClampingScrollPhysics(),
  //             children: const [HomeView(), VerseListView()],
  //           );
  //         } else if (snapshot.hasError) {
  //           return const CircularProgressIndicator();
  //         } else {
  //           return const CircularProgressIndicator();
  //         }
  //       },
  //     ),
  //   );
  // }
}
