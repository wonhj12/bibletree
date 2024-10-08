import 'dart:ui';
import 'package:bibletree/config/palette.dart';
import 'package:bibletree/viewModels/growth_view_model.dart';
import 'package:bibletree/widgets/tree_image.dart';
import 'package:bibletree/widgets/shaker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GrowthView extends StatefulWidget {
  const GrowthView({super.key});

  @override
  State<GrowthView> createState() => _GrowthViewState();
}

class _GrowthViewState extends State<GrowthView> {
  // Tree related variables
  // final TreeManager _treeManager = TreeManager(); // Tree Manager

  // int _count = 3; // Number of taps before closing
  // bool _isShaking = false; // Animation shake

  // final int _shakeDuration = 200; // Shake duration in milliseconds
  // final double _shakeWidth = 15; // Shake width distance

  @override
  Widget build(BuildContext context) {
    GrowthViewModel growthViewModel = context.watch<GrowthViewModel>();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tree text
            Text(
              growthViewModel.treeDescription(),
              style: const TextStyle(fontSize: Palette.body),
            ),

            const SizedBox(height: 16),

            // Tree
            GestureDetector(
              onTap: () => growthViewModel.onTapTree(),
              // {
              //   tapTree();
              // },
              child: Shaker(
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      color: Palette.green200,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        alignment: Alignment(0, 3.8),
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/base.png'),
                      ),
                    ),
                    child: TreeImage(
                      treeName: growthViewModel.userModel.getCurTree(),
                    ),
                  ),
                ),
                growthViewModel.isShaking ? growthViewModel.shakeDuration : 1,
                growthViewModel.shakeWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Tap tree 3 times to close
  // void tapTree() {
  //   if (_count > 0) {
  //     setState(() {
  //       _count -= 1;
  //       _isShaking = true;
  //     });
  //     Future.delayed(Duration(milliseconds: _shakeDuration), () {
  //       setState(() {
  //         _isShaking = false;
  //       });
  //     });

  //     if (_count == 0) {
  //       Future.delayed(Duration(milliseconds: _shakeDuration)).then(
  //         (value) async {
  //           if (!mounted) return;
  //           Navigator.pop(context);
  //         },
  //       );
  //     }
  //   }
  // }
}
