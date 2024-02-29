import 'dart:ui';

import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/views/tree/tree_view.dart';
import 'package:bibletree/views/widgets/shaker.dart';
import 'package:flutter/material.dart';

class GrowthView extends StatefulWidget {
  const GrowthView({super.key});

  @override
  State<GrowthView> createState() => _GrowthViewState();
}

class _GrowthViewState extends State<GrowthView> {
  int _count = 3; // Number of taps before closing
  bool _isShaking = false; // Animation shake
  final int _shakeDuration = 200; // Shake duration in milliseconds
  final double _shakeWidth = 15; //Shake width distance

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tree
            GestureDetector(
              onTap: () {
                tapTree();
              },
              child: Shaker(
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const TreeView(),
                  ),
                ),
                _isShaking ? _shakeDuration : 1,
                _shakeWidth,
              ),
            ),

            const SizedBox(height: 12),

            // Tree text
            const Text(
              '나무를 탭해서 물을 주세요!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: AppStatics.title,
                  fontWeight: AppStatics.medium),
            ),
          ],
        ),
      ),
    );
  }

  /// Tap tree 3 times to close
  void tapTree() {
    if (_count > 0) {
      setState(() {
        _count -= 1;
        _isShaking = true;
      });
      Future.delayed(Duration(milliseconds: _shakeDuration), () {
        setState(() {
          _isShaking = false;
        });
      });

      if (_count == 0) {
        Future.delayed(Duration(milliseconds: _shakeDuration))
            .then((value) => Navigator.pop(context));
      }
    }
  }
}
