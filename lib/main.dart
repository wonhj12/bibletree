import 'package:bibletree/models/singleton.dart';
import 'package:bibletree/statics/app_statics.dart';
import 'package:bibletree/views/home_view.dart';
import 'package:bibletree/views/verse_list_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: AppStatics.body,
              fontWeight: AppStatics.medium,
              color: Colors.black),
        ),
      ),
      themeMode: ThemeMode.system,
      home: FutureBuilder(
        future: _singleton.loadVerses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _singleton.list = snapshot.data!;
            return PageView(
              physics: const ClampingScrollPhysics(),
              children: const [HomeView(), VerseListView()],
            );
          } else if (snapshot.hasError) {
            return const CircularProgressIndicator();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
