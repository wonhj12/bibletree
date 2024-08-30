// import 'package:bibletree/bloc/record_bloc.dart';
// import 'package:bibletree/dao/record_dao.dart';
// import 'package:bibletree/repositories/record_repository.dart';
import 'package:bibletree/models/verse.dart';
import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/viewModels/record_view_model.dart';
import 'package:bibletree/widgets/text_input_view.dart';
import 'package:bibletree/widgets/verse_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  // final RecordBloc _recordBloc = RecordBloc(RecordRepository(RecordDao()));

  @override
  Widget build(BuildContext context) {
    RecordViewModel recordViewModel = context.watch<RecordViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('오늘의 말씀'),
        // 닫기 버튼
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // 좋아요 버튼
          IconButton(
            onPressed: () => recordViewModel.onPressedLike(),
            // {
            // setState(() {
            //   _like = !_like;
            // });

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
            // },
            icon: Icon(
              recordViewModel.like ? Icons.favorite : Icons.favorite_outline,
              color: recordViewModel.like ? Colors.red : null,
            ),
          ),

          // 저장 버튼
          IconButton(
            onPressed: () => recordViewModel.onPressedSave(),
            // {
            //   bool newRecord = false;

            //   // if (widget.record == null) {
            //   //   // Create new record
            //   //   _recordBloc.createRecord(RecordItem(
            //   //       null, widget.verse.id, _like, _thought, DateTime.now()));
            //   //   newRecord = true; // Set can water to true
            //   // } else {
            //   //   // Update record
            //   //   RecordItem update = RecordItem(
            //   //       widget.record!.id,
            //   //       widget.record!.verseId,
            //   //       _like,
            //   //       _thought,
            //   //       widget.record!.createdAt);
            //   //   _recordBloc.updateRecord(update);
            //   // }
            //   if (!context.mounted) return;
            //   Navigator.pop(context, newRecord);
            // },
            icon: const Icon(Icons.check_outlined),
          )
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
                Container(
                  margin: const EdgeInsets.all(24),
                  child: VerseCard(Verse(
                    id: 0,
                    book: 'book',
                    chapter: 'chapter',
                    verse: 'verse',
                  )),
                ),

                // Input view
                Container(
                  margin: const EdgeInsets.all(24),
                  child: TextInputView(
                    thought: recordViewModel.recordModel.thought,
                    onTextChanged: (text) =>
                        recordViewModel.onTextChanged(text),
                    // {
                    //   setState(() {
                    //     _thought = text;
                    //   });
                    // },
                  ),
                ),

                const Spacer(),

                // 날짜
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${DateFormat('yyyy.MM.dd').format(recordViewModel.recordModel.createdAt ?? DateTime.now())} 말씀묵상',
                    style: TextStyle(
                      fontSize: AppStatics.footnote,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
