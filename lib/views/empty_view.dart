import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '묵상한 말씀이 없습니다',
        style: TextStyle(fontSize: AppStatics.body),
      ),
    );
  }
}
