import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dict/word_sets.dart';
import '../models/game_model.dart';

Map<String, List<String>> setsTable = {
  "basic": basic,
  "expert": expert,
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

  void setDuration(int dur) {
    state = state.copyWith(duration: dur);
  }

  void setWordsToWin(int quantity) {
    state = state.copyWith(wordsToWin: quantity);
  }

  void setlastWord(bool lastWord) {
    state = state.copyWith(lastWord: lastWord);
  }

  void reset() {
    state = state.copyWith(
        teams: ["Super Mario", "Not Ready yet"],
        scores: [0, 0],
        turn: 0,
        usedWords: {},
        usedWordSets: []);
  }

  void makeGameWordSet(List<String> sets) {
    List<String> gameSets = [];
    for (String set in sets) {
      gameSets += setsTable[set]!;
    }

    state = state.copyWith(usedWordSets: gameSets);
  }

  void addUsedWord(String word) {
    final updatedUsedWords = Set<String>.from(state.usedWords);
    updatedUsedWords.add(word);
    state = state.copyWith(usedWords: updatedUsedWords);

    if (state.usedWords.length == state.usedWordSets.length) {
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

  void updateScore(int index, int score) {
    state.scores[index] += score;
  }
}


/// TO DO
/// add Sets selection, mix them and save as one array for a game