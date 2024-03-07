import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/models/record_item.dart';
import 'package:bibletree/models/singleton.dart';
import 'package:bibletree/models/verse.dart';
import 'package:bibletree/statics/app_statics.dart';
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
      // color: AppStatics.green,

      // BG image
      decoration: const BoxDecoration(
        color: AppStatics.green,
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/base.png'),
        ),
      ),

      // Home components
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
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
                  margin: const EdgeInsets.fromLTRB(16, 100, 16, 0),
                  child: VerseView(
                      todayVerse.verse, todayVerse.book, todayVerse.chapter),
                ),
              ),

              const Spacer(),

              // Tree view
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 100),
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
