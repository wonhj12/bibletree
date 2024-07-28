import 'package:bibletree/bloc/record_bloc.dart';
import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/models/verse_singleton.dart';
import 'package:bibletree/repositories/record_repository.dart';
import 'package:bibletree/models/record_item.dart';
import 'package:bibletree/views/empty_view.dart';
import 'package:bibletree/views/record/record_view.dart';
import 'package:bibletree/views/verse_list_card.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';

class VerseListView extends StatefulWidget {
  const VerseListView({super.key});

  @override
  State<VerseListView> createState() => _VerseListViewState();
}

class _VerseListViewState extends State<VerseListView> {
  // Data related variables
  final RecordBloc _recordBloc = RecordBloc(RecordRepository(RecordDao()));

  bool _like = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('묵상 목록'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _like = !_like;
              });
            },
            icon: Icon(_like ? Icons.favorite : Icons.favorite_outline,
                color: _like ? Colors.red : null),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _recordBloc.recordListStream,
          builder: (context, AsyncSnapshot<List<RecordItem>> snapshot) {
            if (snapshot.hasData) {
              List<RecordItem> records = _like
                  ? snapshot.data!.where((record) => record.like).toList()
                  : snapshot.data!;

              return records.isEmpty
                  ? const EmptyView()
                  : ImplicitlyAnimatedList(
                      itemData: records,
                      itemBuilder: (_, record) {
                        print(record.id);
                        return listItem(record);
                      },
                      itemEquality: (a, b) => a.verseId == b.verseId,
                    );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget listItem(RecordItem record) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 6, 24, 6),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => RecordView(
                      record, VerseSingleton.instance.list[record.verseId])))
              .then((value) => _recordBloc.getRecordList());
        },
        child:
            VerseListTile(verse: VerseSingleton.instance.list[record.verseId]),
      ),
    );
  }
}
