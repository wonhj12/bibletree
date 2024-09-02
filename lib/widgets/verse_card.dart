import 'package:bibletree/models/verse.dart';
import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

/// 말씀 카드 위젯
/// * `Verse verse`
class VerseCard extends StatelessWidget {
  final Verse verse;

  const VerseCard(this.verse, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 말씀
        Text(
          verse.verse,
          style: const TextStyle(
            fontSize: AppStatics.title,
            fontWeight: AppStatics.medium,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),

        // 장:절
        Text(
          '${verse.book} ${verse.chapter}',
          style: TextStyle(
            fontSize: AppStatics.body,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
