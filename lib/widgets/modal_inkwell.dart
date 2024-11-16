import 'package:bibletree/config/palette.dart';
import 'package:flutter/material.dart';

/// `CustomModal`에서 버튼으로 사용되는 Inkwell 위젯
/// * `String title`
/// * `bool isTop` : 첫 버튼 여부. 상단 둥근 모서리 적용
/// * `bool isBottom` : 마지막 버튼 여부. 하단 둥근 모서리 적용
/// * `VoidCallback? onTap`
class ModalInkwell extends StatelessWidget {
  final String title;
  final bool isTop;
  final bool isBottom;
  final bool isAlert;
  final VoidCallback? onTap;

  const ModalInkwell({
    super.key,
    required this.title,
    this.isTop = false,
    this.isBottom = false,
    this.isAlert = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Operate onTap function
            if (onTap != null) onTap!();
            // Close modal
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(isTop ? 10 : 0),
            bottom: Radius.circular(isBottom ? 10 : 0),
          ),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: Palette.body,
                fontWeight: isAlert ? Palette.medium : Palette.regular,
                color: isAlert ? Palette.alert : Palette.primary,
              ),
            ),
          ),
        ),

        // Add divider if not last element
        !isBottom
            ? Divider(
                height: 0, color: Theme.of(context).colorScheme.onTertiary)
            : Container(),
      ],
    );
  }
}
