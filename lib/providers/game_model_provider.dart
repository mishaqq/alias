import 'dart:math';

import 'package:alias/core/constants.dart';
import 'package:alias/providers/locale_provider.dart';
import 'package:alias/providers/setsProvider.dart';
import 'package:alias/screens/winning_screen.dart';
import 'package:alias/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dict/team_names.dart';
import '../models/game_model.dart';

// Game Provider
final gameProvider = StateNotifierProvider<GameNotifier, AliasData>((ref) {
  return GameNotifier(
    AliasData(
      teams: initTeams(),
      scores: [0, 0],
      turn: 0,
      usedWords: {},
      setsNames: [],
      avatars: [],
      duration: 60,
      wordsToWin: 20,
      lastWord: true,
      oldSesion: false,
    ),
    ref,
    ref.watch(localeProvider.notifier),
  );
});

// Game Object
class GameNotifier extends StateNotifier<AliasData> {
  final Ref ref;
  final LocaleNotifier _localeNotifier;
  GameNotifier(
    super.state,
    this.ref,
    this._localeNotifier,
  );

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
    final updatedTeamsAvatars = List<String>.from(state.avatars);
    final random = Random();

    // team update
    String team = team_names[random.nextInt(team_names.length)];
    while (state.teams.contains(team)) {
      team = team_names[random.nextInt(team_names.length)];
    }

    if (state.teams.length > 10) {
      return;
    }
    updatedTeams.add(team);

// score update
    final updatedScores = List<int>.from(state.scores);
    updatedScores.add(0);

// avatar update
    String avatar = images[random.nextInt(images.length)];
    while (state.avatars.contains(avatar)) {
      avatar = images[random.nextInt(images.length)];
    }
    updatedTeamsAvatars.add(avatar);

    state = state.copyWith(
        teams: updatedTeams,
        scores: updatedScores,
        avatars: updatedTeamsAvatars);
  }

  void deleteTeam(int index) {
    final updatedTeams = List<String>.from(state.teams);
    final updatedScores = List<int>.from(state.scores);
    final updatedTeamsAvatars = List<String>.from(state.avatars);
    updatedTeams.removeAt(index);
    updatedScores.removeAt(index);
    updatedTeamsAvatars.removeAt(index);

    state = state.copyWith(
        teams: updatedTeams,
        scores: updatedScores,
        avatars: updatedTeamsAvatars);
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

  void setWordsToWin(context, int quantity) {
    state = state.copyWith(wordsToWin: quantity);
  }

  void setlastWord(bool lastWord) {
    state = state.copyWith(lastWord: lastWord);
  }

  void reset() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    state = state.copyWith(
      teams: initTeams(),
      scores: [0, 0],
      turn: 0,
      usedWords: {},
      setsNames: [],
      avatars: initTeamsAvatars(),
      duration: 60,
      wordsToWin: 20,
      lastWord: true,
      oldSesion: pref.getBool("oldSesion"),
    );
  }

  void oldSesionTrue() {
    state = state.copyWith(
      oldSesion: true,
    );
  }

  void makeGameWordSet(List<String> sets) async {
    ref.read(setsProvider.notifier).updateWords(sets);

    state = state.copyWith(setsNames: sets);
  }

  void addUsedWord(String word) {
    final updatedUsedWords = Set<String>.from(state.usedWords);
    updatedUsedWords.add(word);
    state = state.copyWith(usedWords: updatedUsedWords);

    if (state.usedWords.length == ref.read(setsProvider).length) {
      state = state.copyWith(usedWords: {});
    }
  }

  String selectRandomWord() {
    final random = Random();
    List<String> allWords = ref.read(setsProvider);
    String word = allWords[random.nextInt(allWords.length)];

    while (state.usedWords.contains(word)) {
      word = allWords[random.nextInt(allWords.length)];
    }

    return word;
  }

  void updateScore(int index, int score) {
    state.scores[index] += score;
    updateTurnsAndScore();
  }

  void winCheck(BuildContext context) {
    List<int> scores = [];
    List<String> winnersNames = [];
    for (int el = 0; el < state.scores.length; el++) {
      if (state.scores[el] >= state.wordsToWin) {
        scores.add(state.scores[el]);
      }
    }
    if (scores.isEmpty) {
      Navigator.pop(context);
      return;
    }
    scores.sort();
    int maxScore = scores.last;

    for (int i = 0; i < state.scores.length; i++) {
      if (state.scores[i] == maxScore) {
        winnersNames.add(state.teams[i]);
      }
    }

    if (winnersNames.isNotEmpty) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WinningPage(
              winners: winnersNames,
            ),
          ));
    }
  }

  ///
  /// Shared preferences Section
  ///

// updates the game object whether it was a old session
  Future<void> oldGame() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    state = state.copyWith(
      oldSesion: pref.getBool("oldSesion") ?? false,
    );
  }

// Writes game date to SP
  Future<void> writeToPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setStringList('teams', state.teams);
    await pref.setStringList('avatars', state.avatars);
    await pref.setStringList('setsNames', state.setsNames);
    await pref.setStringList('scores', intArrToString(state.scores));
    await pref.setInt('turn', state.turn);
    await pref.setInt('duration', state.duration);
    await pref.setInt('wordsToWin', state.wordsToWin);
    await pref.setStringList('usedWords', state.usedWords.toList());
    await pref.setBool('lastWord', state.lastWord);
    await pref.setBool('oldSesion', true);
  }

// fetches game data from the SP (SharedPreferences) to GameObject
  Future<void> readFormPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    state = state.copyWith(
      teams: pref.getStringList('teams') ?? initTeams(),
      avatars: pref.getStringList('avatars') ?? initTeamsAvatars(),
      scores: stringArrToInt(pref.getStringList('scores') ?? ["0 ", "0 "]),
      turn: pref.getInt('turn'),
      usedWords: pref.getStringList('usedWords')?.toSet() ?? {},
      setsNames: pref.getStringList('setsNames') ?? [],
      duration: pref.getInt('duration'),
      wordsToWin: pref.getInt('wordsToWin'),
      lastWord: pref.getBool('lastWord'),
      oldSesion: pref.getBool('oldSesion'),
    );
  }

// Updates score and turns
  Future<void> updateTurnsAndScore() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('scores', intArrToString(state.scores));
    await pref.setInt('turn', state.turn);
  }

// not in use but may be helpfull

  Future<void> deleteFromPrefs(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      pref.clear();
      await pref.remove('teams');
      await pref.remove('avatars');
      await pref.remove('setsNames');
      await pref.remove('scores');
      await pref.remove('turn');
      await pref.remove('duration');
      await pref.remove('wordsToWin');
      await pref.remove('usedWords');
      await pref.remove('lastWord');
      await pref.remove('oldSesion');
      state = state.copyWith(oldSesion: false);
    } catch (err) {} // TO DO
    // add err handling
  }
}

///
/// Global Scope
///

// Help functions

List<String> intArrToString(List<int> arr) {
  List<String> strArr = [];
  for (int i = 0; i < arr.length; i++) {
    strArr.add(arr[i].toString());
  }
  return strArr;
}

List<int> stringArrToInt(List<String> arr) {
  List<int> intAr = [];
  for (int i = 0; i < arr.length; i++) {
    intAr.add(int.parse(arr[i]));
  }
  return intAr;
}
