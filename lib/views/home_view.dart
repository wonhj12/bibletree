import 'package:bibletree/dao/record_dao.dart';
import 'package:bibletree/models/record_item.dart';
import 'package:bibletree/models/singleton.dart';
import 'package:bibletree/models/tree_manager.dart';
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
  late SharedPreferences _prefs;

  // Data related variables
  final Singleton _singleton = Singleton(); // Verses
  final RecordDao _dao = RecordDao(); // Record dao

  // Tree related variables
  final TreeManager _treeManager = TreeManager(); // Tree Manager

  RecordItem? _todayRecord; // Today Record item
  int _todayId = 0; // today id

  /// Fetch today record from database
  void initialize() async {
    _prefs = await SharedPreferences.getInstance();

    // Get today's id
    int id = _prefs.getInt(PrefVals.todayId) ?? 0;

    // Get last login DateTime
    final lastLogin = DateTime.fromMillisecondsSinceEpoch(
        _prefs.getInt(PrefVals.lastLogin) ?? 0);
    // Check if recorded
    final recorded = _prefs.getBool(PrefVals.recorded) ?? false;
    // last login time is not today == yesterday or before
    if (!DateUtils.isSameDay(lastLogin, DateTime.now()) && recorded) {
      id = id + 1;
      await _prefs.setInt(PrefVals.todayId, id);
      await _prefs.setInt(
          PrefVals.lastLogin, DateTime.now().millisecondsSinceEpoch);
      await _prefs.setBool(PrefVals.recorded, false);
    }

    // Get record from database
    final record = await _dao.getRecordItem(id);

    // Get tree growth
    final growth = _prefs.getInt(PrefVals.growth) ?? 0;

    setState(() {
      _todayId = id;
      _todayRecord = record;
      _treeManager.growth = growth;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    Verse todayVerse = _singleton.list[_todayId];

    return Container(
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
                      .then((value) => initialize());
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
                    // Increment tree growth
                    growTree();

                    // Show growth view
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, _, __) {
                          return const GrowthView();
                        },
                      ),
                    );
                  },
                  child: TreeView(treeName: _treeManager.getCurTree()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void growTree() async {
    _treeManager.growth += 1;
    _prefs.setInt(PrefVals.growth, _treeManager.growth);
  }
}
