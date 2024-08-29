import 'package:bibletree/config/app_router.dart';
import 'package:bibletree/model/record_model.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:bibletree/statics/custom_theme_data.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
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

Future<void> initializeData() async {}

// Models
UserModel userModel = UserModel();
RecordModel recordModel = RecordModel();

// 라우터
final _router = AppRouter.getRouter(userModel, recordModel);

class BibleTreeApp extends StatelessWidget {
  const BibleTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: CustomThemeData.light,
      darkTheme: CustomThemeData.dark,
      themeMode: userModel.theme,
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
