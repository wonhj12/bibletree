import 'package:flutter/material.dart';

class WaterImage extends StatelessWidget {
  const WaterImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/water.png',
      key: const ValueKey<String>('water.png'),
      width: 160,
      height: 160,
    );
  }
}
