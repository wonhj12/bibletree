import 'package:flutter/material.dart';

class TreeManager {
  static final TreeManager instance = TreeManager._internal();
  factory TreeManager() => instance;
  TreeManager._internal();

  // Private variables
  final int _growthLevel = 10; // Tree grows to next form every 10 level
  final int _tree = 0; // Specifies which tree is growing

  /// Growth stage of tree
  int growth = 0;

  /// Returns the name of current tree
  String getCurTree() {
    debugPrint('$growth');
    final level = growth ~/ _growthLevel;

    switch (level) {
      case 0:
        return 'seed1.png';
      case 1:
        return 'seed2.png';
      case 2:
        return 'plant1.png';
      case 3:
        return 'plant2.png';
      case 4:
        return 'plant3.png';
      case 5:
        return 'plant4.png';
      case 6:
        if (_tree == 0) {
          return 'tree1.png';
        } else if (_tree == 1) {
          return 'tree2.png';
        } else {
          return 'tree3.png';
        }
      default:
        return 'seed1.png';
    }
  }
}
