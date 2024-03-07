import 'package:flutter/material.dart';

class TreeView extends StatelessWidget {
  const TreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/plant1.png',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
    );
  }
}
