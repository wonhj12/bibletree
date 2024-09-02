import 'package:bibletree/config/palette.dart';
import 'package:flutter/material.dart';

/// VerseListView에서 사용하는 말씀 리스트 카드 위젯
/// * `Verse verse`
/// * `Function()? onTap`
class VerseListCard extends StatelessWidget {
  final String verse;
  final String book;
  final String chapter;
  final Function()? onTap;
  const VerseListCard({
    super.key,
    required this.verse,
    required this.book,
    required this.chapter,
    required this.onTap,
  });

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
              verse,
              style: const TextStyle(fontSize: Palette.body),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '$book $chapter',
              style: TextStyle(
                fontSize: Palette.footnote,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
