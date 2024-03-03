// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AliasData {
  final List<String> teams;
  final List<String> avatars;
  final List<int> scores;
  final int turn;
  final Set<String> usedWords;
  final List<String> setsNames;
  final int duration;
  final int wordsToWin;
  final bool lastWord;
  final bool oldSesion;
  AliasData({
    required this.teams,
    required this.avatars,
    required this.scores,
    required this.turn,
    required this.usedWords,
    required this.setsNames,
    required this.duration,
    required this.wordsToWin,
    required this.lastWord,
    required this.oldSesion,
  });

  AliasData copyWith({
    List<String>? teams,
    List<String>? avatars,
    List<int>? scores,
    int? turn,
    Set<String>? usedWords,
    List<String>? setsNames,
    int? duration,
    int? wordsToWin,
    bool? lastWord,
    bool? oldSesion,
  }) {
    return AliasData(
      teams: teams ?? this.teams,
      avatars: avatars ?? this.avatars,
      scores: scores ?? this.scores,
      turn: turn ?? this.turn,
      usedWords: usedWords ?? this.usedWords,
      setsNames: setsNames ?? this.setsNames,
      duration: duration ?? this.duration,
      wordsToWin: wordsToWin ?? this.wordsToWin,
      lastWord: lastWord ?? this.lastWord,
      oldSesion: oldSesion ?? this.oldSesion,
    );
  }

  @override
  String toString() {
    return 'AliasData(teams: $teams, avatars: $avatars, scores: $scores, turn: $turn, usedWords: $usedWords, setsNames: $setsNames, duration: $duration, wordsToWin: $wordsToWin, lastWord: $lastWord, oldSesion: $oldSesion)';
  }

  @override
  bool operator ==(covariant AliasData other) {
    if (identical(this, other)) return true;

    return listEquals(other.teams, teams) &&
        listEquals(other.avatars, avatars) &&
        listEquals(other.scores, scores) &&
        other.turn == turn &&
        setEquals(other.usedWords, usedWords) &&
        listEquals(other.setsNames, setsNames) &&
        other.duration == duration &&
        other.wordsToWin == wordsToWin &&
        other.lastWord == lastWord &&
        other.oldSesion == oldSesion;
  }

  @override
  int get hashCode {
    return teams.hashCode ^
        avatars.hashCode ^
        scores.hashCode ^
        turn.hashCode ^
        usedWords.hashCode ^
        setsNames.hashCode ^
        duration.hashCode ^
        wordsToWin.hashCode ^
        lastWord.hashCode ^
        oldSesion.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teams': teams,
      'avatars': avatars,
      'scores': scores,
      'turn': turn,
      'usedWords': usedWords.toList(),
      'setsNames': setsNames,
      'duration': duration,
      'wordsToWin': wordsToWin,
      'lastWord': lastWord,
      'oldSesion': oldSesion,
    };
  }
}
