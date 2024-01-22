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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MainPage(),
        '/score': (context) => ScorePage(),
        '/guessing': (context) => GuessingPage(),
        '/set_choosing': (context) => ChoosingPage(),
        '/settings': (context) => SettingsPage(),
        '/team': (context) => TeamPage()
      },
    );
  }
}
