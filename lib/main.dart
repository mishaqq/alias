import 'dart:async';

import 'package:alias/models/game_model.dart';
import 'package:alias/providers/game_model_provider.dart';
import 'package:alias/screens/guessing_page.dart';
import 'package:alias/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/score_page.dart';

final gameProvider = StateNotifierProvider<GameNotifier, AliasData>(
  (ref) => GameNotifier(
    AliasData(
      teams: ["Super Mario", "Not Ready yet"],
      scores: [0, 0],
      turn: 0,
    ),
  ),
);

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
      },
    );
  }
}
