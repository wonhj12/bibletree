import 'package:bibletree/models/verse.dart';
import 'package:bibletree/statics/app_statics.dart';
import 'package:flutter/material.dart';

class VerseView extends StatelessWidget {
  final Verse verse;

  const VerseView(this.verse, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          verse.verse,
          style: const TextStyle(
              fontSize: AppStatics.title, fontWeight: AppStatics.medium),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),
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
