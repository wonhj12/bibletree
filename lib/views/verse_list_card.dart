import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/models/verse.dart';
import 'package:flutter/material.dart';

class VerseListTile extends StatelessWidget {
  final Verse verse;
  const VerseListTile({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          verse.verse,
          style: const TextStyle(fontSize: AppStatics.body),
        ),
        const SizedBox(height: 8),
        Text(
          '${verse.book} ${verse.chapter}',
          style: const TextStyle(
              fontSize: AppStatics.footnote, color: AppStatics.secondary),
        ),
      ],
    );
  }
}
