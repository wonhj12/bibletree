import 'package:bibletree/config/palette.dart';
import 'package:bibletree/models/verse_model.dart';
import 'package:bibletree/viewModels/verse_list_view_model.dart';
import 'package:bibletree/widgets/verse_list_card.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:provider/provider.dart';

class VerseListView extends StatefulWidget {
  const VerseListView({super.key});

  @override
  State<VerseListView> createState() => _VerseListViewState();
}

class _VerseListViewState extends State<VerseListView> {
  // Data related variables
  // final RecordBloc _recordBloc = RecordBloc(RecordRepository(RecordDao()));
  // Verse verse = Verse(id: 0, verse: 'verse', book: 'book', chapter: 'chapter');

  @override
  Widget build(BuildContext context) {
    VerseListViewModel verseListViewModel = context.watch<VerseListViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('묵상 목록'),
        actions: [
          IconButton(
            onPressed: () => verseListViewModel.onPressedLike(),
            // () {
            //   setState(() {
            //     _like = !_like;
            //   });
            // },
            icon: Icon(
              verseListViewModel.like ? Icons.favorite : Icons.favorite_outline,
              color: verseListViewModel.like ? Colors.red : null,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: verseListViewModel.records.isEmpty
            ? const Center(
                child: Text(
                  '묵상한 말씀이 없습니다',
                  style: TextStyle(fontSize: Palette.body),
                ),
              )
            : ImplicitlyAnimatedList(
                itemData: verseListViewModel.records,
                itemBuilder: (_, record) => Container(
                  margin: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                  child: VerseListCard(
                    verse: VerseModel.instance.list[record['verseId']],
                    onTap: () =>
                        verseListViewModel.onTapVerseListCard(record['id']),
                  ),
                ),
                itemEquality: (a, b) => a['verseId'] == b['verseId'],
              ),
      ),

      // SafeArea(
      //   child: StreamBuilder(
      //     stream: _recordBloc.recordListStream,
      //     builder: (context, AsyncSnapshot<List<RecordItem>> snapshot) {
      //       if (snapshot.hasData) {
      //         List<RecordItem> records = _like
      //             ? snapshot.data!.where((record) => record.like).toList()
      //             : snapshot.data!;

      //         return records.isEmpty
      //             ? const EmptyView()
      //             : ImplicitlyAnimatedList(
      //                 itemData: records,
      //                 itemBuilder: (_, record) {
      //                   print(record.id);
      //                   return listItem(record);
      //                 },
      //                 itemEquality: (a, b) => a.verseId == b.verseId,
      //               );
      //       } else {
      //         return const Center(child: CircularProgressIndicator());
      //       }
      //     },
      //   ),
      // ),
    );
  }

  // Widget listItem(RecordItem record) {
  //   return Container(
  //     margin: const EdgeInsets.fromLTRB(24, 6, 24, 6),
  //     child: GestureDetector(
  //       behavior: HitTestBehavior.translucent,
  //       onTap: () {
  //         // Navigator.of(context)
  //         //     .push(MaterialPageRoute(
  //         //         builder: (context) => RecordView(
  //         //             record, VerseSingleton.instance.list[record.verseId])))
  //         //     .then((value) => _recordBloc.getRecordList());
  //       },
  //       child:
  //           VerseListTile(verse: VerseSingleton.instance.list[record.verseId]),
  //     ),
  //   );
  // }
}
