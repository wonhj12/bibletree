import 'package:flutter/material.dart';

/// 나무 이미지 위젯
class TreeImage extends StatelessWidget {
  const TreeImage({required this.treeName, super.key});

  final String treeName;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$treeName',
      key: ValueKey<String>(treeName),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
    );
  }
}
