import 'dart:math';

import 'package:alias/screens/winning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dict/team_names.dart';
import '../dict/word_sets.dart';
import '../main.dart';
import '../models/game_model.dart';

final sharedPreferences =
    FutureProvider((ref) => SharedPreferences.getInstance());

final gameProvider = StateNotifierProvider<GameNotifier, AliasData>((ref) {
  return GameNotifier(
      AliasData(
        teams: initTeams(),
        scores: [0, 0],
        turn: 0,
        usedWords: {},
        usedWordSets: [],
        duration: 60,
        wordsToWin: 20,
        lastWord: true,
      ),
      ref);
});

Map<String, List<String>> setsTable = {
  "basic": basic,
  "expert": expert,
};

class GameNotifier extends StateNotifier<AliasData> {
  final Ref ref;
  GameNotifier(super.state, this.ref);

  ///
  /// Game Logic Section
  ///

  void updateTeams(int index, String name) {
    final updatedTeams = List<String>.from(state.teams);
    updatedTeams[index] = name;

    state = state.copyWith(teams: updatedTeams);
  }

  void addTeam() {
    final updatedTeams = List<String>.from(state.teams);
    final random = Random();
    String team = team_names[random.nextInt(team_names.length)];
    while (state.teams.contains(team)) {
      team = team_names[random.nextInt(team_names.length)];
    }

    if (state.teams.length > 20) {
      return;
    }
    updatedTeams.add(team);

    final updatedScores = List<int>.from(state.scores);
    updatedScores.add(0);

    state = state.copyWith(teams: updatedTeams, scores: updatedScores);
  }

  void deleteTeam(int index) {
    final updatedTeams = List<String>.from(state.teams);
    final updatedScores = List<int>.from(state.scores);
    updatedTeams.removeAt(index);
    updatedScores.removeAt(index);

    state = state.copyWith(teams: updatedTeams, scores: updatedScores);
  }

  void nextTurn() {
    if (state.turn < state.teams.length - 1) {
      state = state.copyWith(turn: (state.turn + 1));
    } else {
      state = state.copyWith(turn: 0);
    }
  }

  void toggleLastWord() {
    state = state.copyWith(lastWord: !state.lastWord);
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

  void reset(context) {
    state = state.copyWith(
      teams: initTeams(),
      scores: [0, 0],
      turn: 0,
      usedWords: {},
      usedWordSets: [],
      duration: 60,
      wordsToWin: 20,
      lastWord: true,
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> makeGameWordSet(List<String> sets) async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> gameSets = [];
    for (String set in sets) {
      gameSets += setsTable[set]!;
    }

    state = state.copyWith(usedWordSets: gameSets);

    // await pref.setStringList('gameSets', state.usedWordSets);
    // print(pref.getStringList('gameSets'));
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

  void winCheck(BuildContext context) {
    List<int> winnersIndexes = [];
    List<String> winners = [];
    for (int el = 0; el < state.scores.length; el++) {
      if (state.scores[el] >= state.wordsToWin) {
        winnersIndexes.add(el);
      }
    }
    for (var element in winnersIndexes) {
      winners.add(state.teams[element]);
    }
    if (winnersIndexes.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WinningPage(
              winners: winners,
            ),
          ));
    } else {
      Navigator.pop(context);
    }
  }

  ///
  /// Shared preferences Section
  ///
}

/// TO DO
/// add Sets selection, mix them and save as one array for a game
