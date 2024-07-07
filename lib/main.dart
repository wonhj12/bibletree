import 'package:bibletree/models/setting_provider.dart';
import 'package:bibletree/models/verse_singleton.dart';
import 'package:bibletree/statics/custom_theme_data.dart';
import 'package:bibletree/views/home_view.dart';
import 'package:bibletree/views/verse_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Initialize singletons
  VerseSingleton.instance;

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomThemeData.light,
      darkTheme: CustomThemeData.dark,
      themeMode: Provider.of<SettingProvider>(context).themeMode,
      home: FutureBuilder(
        // Initialize verse before loading screen
        future: VerseSingleton.instance.loadVerses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            VerseSingleton.instance.list = snapshot.data!;
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
