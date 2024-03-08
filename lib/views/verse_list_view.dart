import 'package:bibletree/bloc/record_bloc.dart';
import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/models/singleton.dart';
import 'package:bibletree/repositories/record_repository.dart';
import 'package:bibletree/models/record_item.dart';
import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/views/empty_view.dart';
import 'package:bibletree/views/record/record_view.dart';
import 'package:bibletree/views/verse_list_card.dart';
import 'package:flutter/material.dart';

class VerseListView extends StatefulWidget {
  const VerseListView({super.key});

  @override
  State<VerseListView> createState() => _VerseListViewState();
}

class _VerseListViewState extends State<VerseListView> {
  // Data related variables
  final Singleton _singleton = Singleton();
  final RecordBloc _recordBloc = RecordBloc(RecordRepository(RecordDao()));

  bool _like = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStatics.green,
      appBar: AppBar(
        title: const Text('묵상 목록',
            style: TextStyle(fontWeight: AppStatics.medium)),
        backgroundColor: AppStatics.green,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _like = !_like;
              });
            },
            icon: Icon(_like ? Icons.favorite : Icons.favorite_outline,
                color: _like ? Colors.red : Colors.black),
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
                  : ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        RecordItem record = records[index];

                        return listItem(record);
                      },
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
                  builder: (context) =>
                      RecordView(record, _singleton.list[record.verseId])))
              .then((value) => _recordBloc.getRecordList());
        },
        child: VerseListTile(verse: _singleton.list[record.verseId]),
      ),
    );
  }
}
