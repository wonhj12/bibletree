import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/models/verse.dart';
import 'package:flutter/material.dart';

/// VerseListView에서 사용하는 말씀 리스트 카드 위젯
/// * `Verse verse`
/// * `Function()? onTap`
class VerseListCard extends StatelessWidget {
  final Verse verse;
  final Function()? onTap;

  const VerseListCard({super.key, required this.verse, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              verse.verse,
              style: const TextStyle(fontSize: AppStatics.body),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${verse.book} ${verse.chapter}',
              style: TextStyle(
                fontSize: AppStatics.footnote,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
