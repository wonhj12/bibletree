import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/models/verse.dart';
import 'package:flutter/material.dart';

class VerseListTile extends StatelessWidget {
  final Verse verse;
  const VerseListTile({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppStatics.green200, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            verse.verse,
            style: const TextStyle(fontSize: AppStatics.body),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${verse.book} ${verse.chapter}',
            style: const TextStyle(
                fontSize: AppStatics.footnote, color: AppStatics.secondary),
          ),
        ],
      ),
    );
  }
}
