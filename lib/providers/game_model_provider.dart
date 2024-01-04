import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dict/word_sets.dart';
import '../models/game_model.dart';

Map<String, List> setsTable = {
  "basic": basic,
};

class GameNotifier extends StateNotifier<AliasData> {
  GameNotifier(super.state);

  void updateTeams(int index, String name) {
    final updatedTeams = List<String>.from(state.teams);
    updatedTeams[index] = name;

    state = state.copyWith(teams: updatedTeams);
  }

  void addTeam(String name) {
    final updatedTeams = List<String>.from(state.teams);
    updatedTeams.add(name);

    final updatedScores = List<int>.from(state.scores);
    updatedScores.add(0);

    state = state.copyWith(teams: updatedTeams, scores: updatedScores);
  }

  void nextTurn() {
    if (state.turn < state.teams.length - 1) {
      state = state.copyWith(turn: (state.turn + 1));
    } else {
      state = state.copyWith(turn: 0);
    }
  }

  void reset() {
    state = state.copyWith(
        teams: ["Super Mario", "Not Ready yet"],
        scores: [0, 0],
        turn: 0,
        usedWords: {},
        usedWordSets: []);
  }

  void addUsedWord(String word) {
    final updatedUsedWords = Set<String>.from(state.usedWords);
    updatedUsedWords.add(word);
    state = state.copyWith(usedWords: updatedUsedWords);

    if (state.usedWords.length == state.usedWordSets.length) {
      /// change testWords
      state = state.copyWith(usedWords: {});
    }
  }

  String selectRandomWord() {
    final random = Random();
    String word = state.usedWordSets[random.nextInt(state.usedWordSets.length)];

    while (state.usedWords.contains(word)) {
      word = state.usedWordSets[random.nextInt(state.usedWordSets.length)];
    }

    return word;
  }
}
