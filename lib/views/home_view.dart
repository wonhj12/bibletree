import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/models/record_item.dart';
import 'package:bibletree/models/singleton.dart';
import 'package:bibletree/models/verse.dart';
import 'package:bibletree/views/record/record_view.dart';
import 'package:bibletree/views/tree/growth_view.dart';
import 'package:bibletree/views/tree/tree_view.dart';
import 'package:bibletree/views/verse_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Data related variables
  final Singleton _singleton = Singleton(); // Verses
  final RecordDao _dao = RecordDao(); // Record daoß

  RecordItem? _todayRecord; // Today Record item
  int _todayId = 0; // today id

  // TODO : first login
  /// Fetch today record from database
  getTodayRecord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('todayId') ?? 1;
    final record = await _dao.getRecordItem(id);
    setState(() {
      _todayId = id;
      _todayRecord = record;
    });
  }

  @override
  void initState() {
    super.initState();
    getTodayRecord();
  }

  @override
  Widget build(BuildContext context) {
    Verse todayVerse = _singleton.list[_todayId];

    return Container(
      // BG image
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/images/base1.png'),
        ),
      ),

      // Home components
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Verse view
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => RecordView(
                              _todayRecord, _singleton.list[_todayId]),
                          fullscreenDialog: true))
                      .then((value) => getTodayRecord());
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(24, 72, 24, 24),
                  child: VerseView(
                      todayVerse.verse, todayVerse.book, todayVerse.chapter),
                ),
              ),

              // Tree view
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.fromLTRB(24, 24, 24, 105),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, _, __) {
                          return const GrowthView();
                        },
                      ),
                    );
                  },
                  child: const TreeView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
