import 'package:bibletree/model/record_model.dart';
import 'package:bibletree/model/setting_model.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:bibletree/viewModels/home_view_model.dart';
import 'package:bibletree/views/home_view.dart';
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
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => HomeViewModel(
              userModel: userModel,
              context: context,
            ),
            child: const HomeView(),
          ),
        ),
      ],
    );
  }
}
