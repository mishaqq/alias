import 'dart:async';
import 'dart:math';

import 'package:alias/dict/team_names.dart';
import 'package:alias/models/game_model.dart';
import 'package:alias/providers/game_model_provider.dart';
import 'package:alias/screens/guessing_page.dart';
import 'package:alias/screens/main_page.dart';
import 'package:alias/screens/setSelection_page.dart';
import 'package:alias/screens/settings_page.dart';
import 'package:alias/screens/team_page.dart';
import 'package:alias/screens/winning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/score_page.dart';

List<String> initTeams() {
  final random = Random();
  Set<String> initialTeams = {};

  while (initialTeams.length < 2) {
    String word = team_names[random.nextInt(team_names.length)];
    initialTeams.add(word);
  }

  return initialTeams.toList();
}

final random = Random();
String word = team_names[random.nextInt(team_names.length)];

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: "Anonymous",
              fontSize: MediaQuery.of(context).size.width * 0.065),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 10,

            shadowColor: Colors.black,
            backgroundColor: Color.fromARGB(
                255, 248, 237, 255), // Color.fromARGB(255, 255, 221, 149),
            foregroundColor: Color.fromARGB(255, 255, 174, 0), //TO FIX
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: MediaQuery.of(context).size.height * 0.0024),
              borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.height * 0.018),
              ),
            ),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MainPage(),
        '/score': (context) => ScorePage(),
        '/guessing': (context) => GuessingPage(),
        '/set_choosing': (context) => ChoosingPage(),
        '/settings': (context) => SettingsPage(),
        '/team': (context) => TeamPage(),
      },
    );
  }
}

// TO DO Fix last word == false