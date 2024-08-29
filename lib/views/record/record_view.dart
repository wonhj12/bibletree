import 'package:bibletree/bloc/record_bloc.dart';
import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/models/record_item.dart';
import 'package:bibletree/models/verse.dart';
import 'package:bibletree/repositories/record_repository.dart';
import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/views/record/text_input_view.dart';
import 'package:bibletree/widgets/verse_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  final RecordBloc _recordBloc = RecordBloc(RecordRepository(RecordDao()));

  String _thought = '';
  bool _like = false;

  @override
  void initState() {
    super.initState();
    // _like = widget.record?.like ?? false;
    // _thought = widget.record?.thought ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('오늘의 말씀'),
        // Close button
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Like button
          IconButton(
              onPressed: () {
                setState(() {
                  _like = !_like;
                });

                // Only update like status when it is edit mode
                // if (widget.record != null) {
                //   RecordItem update = RecordItem(
                //       widget.record!.id,
                //       widget.record!.verseId,
                //       _like,
                //       widget.record!.thought,
                //       widget.record!.createdAt);
                //   _recordBloc.updateRecord(update);
                // }
              },
              icon: Icon(_like ? Icons.favorite : Icons.favorite_outline,
                  color: _like ? Colors.red : null)),

          // Save button
          IconButton(
              onPressed: () async {
                bool newRecord = false;

                // if (widget.record == null) {
                //   // Create new record
                //   _recordBloc.createRecord(RecordItem(
                //       null, widget.verse.id, _like, _thought, DateTime.now()));
                //   newRecord = true; // Set can water to true
                // } else {
                //   // Update record
                //   RecordItem update = RecordItem(
                //       widget.record!.id,
                //       widget.record!.verseId,
                //       _like,
                //       _thought,
                //       widget.record!.createdAt);
                //   _recordBloc.updateRecord(update);
                // }
                if (!context.mounted) return;
                Navigator.pop(context, newRecord);
              },
              icon: const Icon(Icons.check_outlined))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Verse view
                // Container(
                //   margin: const EdgeInsets.all(24),
                //   child: VerseView(
                //     widget.verse.verse,
                //     widget.verse.book,
                //     widget.verse.chapter,
                //   ),
                // ),

                // Input view
                // Container(
                //   margin: const EdgeInsets.all(24),
                //   child: TextInputView(
                //     thought: widget.record?.thought,
                //     onTextChanged: (text) {
                //       setState(() {
                //         _thought = text;
                //       });
                //     },
                //   ),
                // ),

                const Spacer(),

                // 날짜
                // Container(
                //   margin: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                //   alignment: Alignment.bottomRight,
                //   child: Text(
                //     '${DateFormat('yyyy.MM.dd').format(widget.record?.createdAt ?? DateTime.now())} 말씀묵상',
                //     style: TextStyle(
                //       fontSize: AppStatics.footnote,
                //       color: Theme.of(context).colorScheme.onSecondary,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
