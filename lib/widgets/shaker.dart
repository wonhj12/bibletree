import 'dart:async';
import 'package:flutter/material.dart';

/// GrowthView에서 사용되는 화면 흔들림 위젯
/// * `Widget child` : 흔들림을 적용할 위젯
/// * `int duration` ; 흔들림 적용 시간
/// * `double shakeWidth` : 흔들림 크기
class Shaker extends StatefulWidget {
  final Widget child;
  final int duration;
  final double shakeWidth;
  const Shaker(this.child, this.duration, this.shakeWidth, {super.key});

  @override
  State<Shaker> createState() => _ShakerState();
}

class _ShakerState extends State<Shaker> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration * 2),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: widget.shakeWidth).animate(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.repeat(reverse: true);
    Timer(Duration(milliseconds: widget.duration), () => controller.stop());

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double x = 0;
        if (animation.value != widget.shakeWidth) {
          x = animation.value;
        }
        return Transform.translate(offset: Offset(x, 0), child: widget.child);
      },
    );
  }
}
