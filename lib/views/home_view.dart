import 'package:bibletree/viewModels/home_view_model.dart';
import 'package:bibletree/widgets/tree_image.dart';
import 'package:bibletree/widgets/water_image.dart';
import 'package:bibletree/widgets/verse_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // late SharedPreferences _prefs;

  // // Data related variables
  // final RecordDao _dao = RecordDao(); // Record dao

  // // Tree related variables
  // final TreeManager _treeManager = TreeManager(); // Tree Manager

  // RecordItem? _todayRecord; // Today Record item
  // int _todayId = 0; // today id
  // bool _canWater = false; // Water status of tree

  // /// Fetch today record from database
  // void initialize() async {
  //   _prefs = await SharedPreferences.getInstance();

  //   // Check first login
  //   bool firstLogin = _prefs.getBool(PrefVals.firstLogin) ?? true;

  //   // Get today's id
  //   int id = _prefs.getInt(PrefVals.todayId) ?? 0;

  //   // Get last login DateTime
  //   final lastLogin = DateTime.fromMillisecondsSinceEpoch(
  //       _prefs.getInt(PrefVals.lastLogin) ?? 0);

  //   if (firstLogin) {
  //     await _prefs.setBool(PrefVals.firstLogin, false);
  //     await _prefs.setInt(
  //         PrefVals.lastLogin, DateTime.now().millisecondsSinceEpoch);
  //   } else if (!DateUtils.isSameDay(lastLogin, DateTime.now())) {
  //     // last login time is not today
  //     // Update today id
  //     id = id + 1;
  //     await _prefs.setInt(PrefVals.todayId, id);
  //     // Update login time
  //     await _prefs.setInt(
  //         PrefVals.lastLogin, DateTime.now().millisecondsSinceEpoch);
  //   }

  //   // Get record from database
  //   final record = await _dao.getRecordItem(id);

  //   // Get tree growth
  //   final growth = _prefs.getInt(PrefVals.growth) ?? 0;

  //   // Get tree name
  //   final name = _prefs.getString(PrefVals.treeName) ?? '나무';

  //   // Get water status
  //   final canWater = _prefs.getBool(PrefVals.canWater) ?? false;

  //   setState(() {
  //     _todayId = id;
  //     _todayRecord = record;
  //     _treeManager.growth = growth;
  //     _treeManager.name = name;
  //     _canWater = canWater;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initialize();
  // }

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = context.watch<HomeViewModel>();
    // Verse todayVerse =
    //     Verse(id: 0, verse: 'verse', book: 'book', chapter: 'chapter');
    //VerseSingleton.instance.list[userModel.verseId];

    return Container(
      // BG image
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        image: const DecorationImage(
          alignment: Alignment.bottomCenter,
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/base.png'),
        ),
      ),

      // Home components
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => homeViewModel.onPressedSetting(),
            //  {
            //   // Open settings
            //   Navigator.of(context)
            //       .push(
            //     MaterialPageRoute(builder: (context) => const SettingView()),
            //   )
            //       .then((value) {
            //     if (value != null && value) {
            //       // Reload home view if data reset
            //       initialize();
            //     }
            //   });
            // },
            icon: const Icon(Icons.format_list_bulleted),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // Verse view
              GestureDetector(
                onTap: () => homeViewModel.onTapVerseCard(),
                // {
                //   Navigator.of(context)
                //       .push(MaterialPageRoute(
                //           builder: (context) => RecordView(_todayRecord,
                //               VerseSingleton.instance.list[_todayId]),
                //           fullscreenDialog: true))
                //       .then((value) {
                //     // Set water status to true if new record is entered
                //     if (value != null) setWater(value);
                //     initialize();
                //   });
                // },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 54, 16, 0),
                  child: const VerseCard(
                    verse: 'verse',
                    book: 'book',
                    chapter: 'chapter',
                  ),
                ),
              ),

              const Spacer(),

              // Tree view
              Stack(
                alignment: Alignment.topRight,
                children: [
                  // Plant image
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 100),
                    child: TreeImage(
                        treeName: homeViewModel.userModel.getCurTree()),
                  ),

                  // Water
                  if (homeViewModel.canWater)
                    GestureDetector(
                      onTap: () => homeViewModel.onTapWater(),
                      // {
                      //   // Increment tree growth
                      //   growTree();
                      //   setWater(false);

                      //   // Show growth view
                      //   Navigator.of(context)
                      //       .push(
                      //     PageRouteBuilder(
                      //       opaque: false,
                      //       pageBuilder: (context, _, __) {
                      //         return const GrowthView();
                      //       },
                      //     ),
                      //   )
                      //       .then(
                      //     (_) async {
                      //       if (_treeManager.needName) {
                      //         String? name = await showDialog(
                      //           context: context,
                      //           barrierDismissible: false,
                      //           builder: (BuildContext context) =>
                      //               const NameAlert(),
                      //         );

                      //         if (name != null && name.isNotEmpty) {
                      //           _treeManager.needName = false;
                      //           _treeManager.name = name;
                      //           _prefs.setString(PrefVals.treeName, name);
                      //         }
                      //       }
                      //     },
                      //   );
                      // },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16, top: 16),
                        child: const WaterImage(),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Increment tree growth and save to prefs
//   void growTree() async {
//     setState(() {
//       _treeManager.growth += 1;
//     });

//     await _prefs.setInt(PrefVals.growth, _treeManager.growth);
//   }

//   /// Set water status of tree
//   void setWater(bool canWater) async {
//     setState(() {
//       _canWater = (canWater);
//     });

//     await _prefs.setBool(PrefVals.canWater, canWater);
//   }
}
