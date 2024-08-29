import 'package:bibletree/model/user_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  UserModel userModel;

  HomeViewModel({required this.userModel});
}
