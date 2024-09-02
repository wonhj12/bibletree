import 'package:bibletree/config/palette.dart';
import 'package:bibletree/models/verse_model.dart';
import 'package:flutter/material.dart';

/// 말씀 카드 위젯
/// * `Verse verse`
class VerseCard extends StatelessWidget {
  final Verse verse;

  const VerseCard({
    super.key,
    required this.verse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 말씀
        Text(
          verse.verse,
          style: const TextStyle(
            fontSize: Palette.title,
            fontWeight: Palette.medium,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),

        // 장:절
        Text(
          '${verse.book} ${verse.chapter}',
          style: TextStyle(
            fontSize: Palette.body,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
