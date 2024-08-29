import 'package:bibletree/model/record_model.dart';
import 'package:bibletree/model/user_model.dart';
import 'package:bibletree/viewModels/home_view_model.dart';
import 'package:bibletree/views/home_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final UserModel userModel;
  final RecordModel recordModel;
  AppRouter({required this.userModel, required this.recordModel});

  static GoRouter getRouter(UserModel userModel, RecordModel recordModel) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => HomeViewModel(userModel: userModel),
            child: const HomeView(),
          ),
        ),
      ],
    );
  }
}
