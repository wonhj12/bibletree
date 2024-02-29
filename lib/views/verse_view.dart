import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

class VerseView extends StatelessWidget {
  const VerseView(this.verse, this.book, this.chapter, {super.key});

  final String verse;
  final String book;
  final String chapter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          verse,
          style: const TextStyle(
              fontSize: AppStatics.title, fontWeight: AppStatics.medium),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),
        Text(
          '$book $chapter',
          style: const TextStyle(
            fontSize: AppStatics.body,
            color: AppStatics.secondary,
          ),
        ),
      ],
    );
  }
}
