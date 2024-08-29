import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/widgets.dart';

class SettingHeader extends StatelessWidget {
  final String title;
  const SettingHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: AppStatics.body, fontWeight: AppStatics.medium),
      ),
    );
  }
}
