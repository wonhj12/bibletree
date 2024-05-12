import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('설정', style: TextStyle(fontWeight: AppStatics.medium)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: AppStatics.green,
      ),
      backgroundColor: AppStatics.green,
    );
  }
}
