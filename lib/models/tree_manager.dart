class TreeManager {
  static final TreeManager instance = TreeManager._internal();
  factory TreeManager() => instance;
  TreeManager._internal();

  // Private variables
  final int _growthLevel = 10; // Tree grows to next form every 10 level
  final int _tree = 0; // Specifies which tree is growing

  /// Growth stage of tree
  int growth = 0;

  bool needName = false; // Tree reached level 1 but has no name
  String name = '나무';

  /// Tree description string
  String treeDescription() {
    int level = growth % _growthLevel == 0 ? growth ~/ _growthLevel : -1;

    switch (level) {
      case 0:
        return '새로운 생명이네요! 어떤 나무로 자라게 될까요?';
      case 1:
        needName = true;
        return '새싹이 인사하네요! 이름을 지어 줄까요?';
      case 2:
        return '$name(이)의 줄기가 자랐네요!';
      case 3:
        return '$name(이)의 잎이 활짝 폈어요!';
      case 4:
        return '$name(이)에게 꽃봉우리가 생겼네요!';
      case 5:
        return '$name(이)가 예쁜 꽃을 활짝 폈어요';
      case 6:
        if (_tree == 0) {
          return '$name(이)가 상수리 나무로 자랐어요!';
        } else if (_tree == 1) {
          return '$name(이)가 백향목으로 자랐어요!';
        } else {
          return '$name(이)가 올리브 나무로 자랐어요!';
        }
      default:
        return '나무를 탭해서 물을 주세요!';
    }
  }

  /// Returns the name of current tree
  String getCurTree() {
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
