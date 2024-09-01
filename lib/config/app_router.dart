import 'package:bibletree/model/record_model.dart';
import 'package:bibletree/model/setting_model.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:bibletree/viewModels/growth_view_model.dart';
import 'package:bibletree/viewModels/home_view_model.dart';
import 'package:bibletree/viewModels/record_view_model.dart';
import 'package:bibletree/viewModels/setting_view_model.dart';
import 'package:bibletree/viewModels/verse_list_view_model.dart';
import 'package:bibletree/views/growth_view.dart';
import 'package:bibletree/views/home_view.dart';
import 'package:bibletree/views/record_view.dart';
import 'package:bibletree/views/setting_view.dart';
import 'package:bibletree/views/verse_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final UserModel userModel;
  final RecordModel recordModel;
  final SettingModel settingModel;

  AppRouter({
    required this.userModel,
    required this.recordModel,
    required this.settingModel,
  });

  static GoRouter getRouter(
    UserModel userModel,
    RecordModel recordModel,
    SettingModel settingModel,
  ) {
    return GoRouter(
      initialLocation: '/home',
      routes: <RouteBase>[
        StatefulShellRoute(
          navigatorContainerBuilder: (BuildContext context,
              StatefulNavigationShell navigationShell, List<Widget> children) {
            return PageView(
              physics: const ClampingScrollPhysics(),
              onPageChanged: (index) => navigationShell.goBranch(index),
              children: children,
            );
          },
          builder: (context, state, navigationShell) => navigationShell,
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: [
                // 홈 페이지
                GoRoute(
                  path: '/home',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => HomeViewModel(
                      userModel: userModel,
                      recordModel: recordModel,
                      context: context,
                    ),
                    child: const HomeView(),
                  ),
                  routes: [
                    // Record 등록/수정 페이지
                    GoRoute(
                      path: 'record',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => RecordViewModel(
                          recordModel: recordModel,
                          context: context,
                        ),
                        child: const RecordView(),
                      ),
                    ),

                    // 나무 물주기 페이지
                    GoRoute(
                      path: 'water',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => GrowthViewModel(
                          userModel: userModel,
                          context: context,
                        ),
                        child: const GrowthView(),
                      ),
                    ),

                    // 설정
                    GoRoute(
                      path: 'setting',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => SettingViewModel(
                          userModel: userModel,
                          settingModel: settingModel,
                          recordModel: recordModel,
                          context: context,
                        ),
                        child: const SettingView(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                // 말씀 리스트 페이지
                GoRoute(
                  path: '/verse-list',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => VerseListViewModel(
                      recordModel: recordModel,
                      context: context,
                    ),
                    child: const VerseListView(),
                  ),
                  routes: [
                    // Record 수정 페이지
                    GoRoute(
                      path: 'record',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => RecordViewModel(
                          recordModel: recordModel,
                          context: context,
                        ),
                        child: const RecordView(),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
