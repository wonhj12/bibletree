import 'package:bibletree/config/palette.dart';
import 'package:flutter/material.dart';

/// SettingView에서 설정 메뉴로 사용되는 위젯
/// * `String name` : 메뉴 명
/// * `String value` : 메뉴 값
/// * `Function()? onTap`
class SettingInkwell extends StatelessWidget {
  final String name;
  final String value;
  final Function()? onTap;

  const SettingInkwell({
    super.key,
    required this.name,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: Palette.body,
                fontWeight: Palette.regular,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: Palette.body,
                fontWeight: Palette.regular,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
