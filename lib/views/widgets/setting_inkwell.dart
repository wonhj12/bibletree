import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

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
                fontSize: AppStatics.body,
                fontWeight: AppStatics.regular,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: AppStatics.body,
                fontWeight: AppStatics.regular,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
