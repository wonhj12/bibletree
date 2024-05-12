import 'package:flutter/material.dart';

class TreeView extends StatelessWidget {
  const TreeView({required this.treeName, super.key});

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
