// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AliasData {
  final List<String> teams;
  final List<int> scores;
  final int turn;
  final Set<String> usedWords;
  final List<String> usedWordSets;
  final int duration;
  final int wordsToWin;
  final bool lastWord;
  AliasData({
    required this.teams,
    required this.scores,
    required this.turn,
    required this.usedWords,
    required this.usedWordSets,
    required this.duration,
    required this.wordsToWin,
    required this.lastWord,
  });

  AliasData copyWith({
    List<String>? teams,
    List<int>? scores,
    int? turn,
    Set<String>? usedWords,
    List<String>? usedWordSets,
    int? duration,
    int? wordsToWin,
    bool? lastWord,
  }) {
    return AliasData(
      teams: teams ?? this.teams,
      scores: scores ?? this.scores,
      turn: turn ?? this.turn,
      usedWords: usedWords ?? this.usedWords,
      usedWordSets: usedWordSets ?? this.usedWordSets,
      duration: duration ?? this.duration,
      wordsToWin: wordsToWin ?? this.wordsToWin,
      lastWord: lastWord ?? this.lastWord,
    );
  }

  @override
  String toString() {
    return 'AliasData(teams: $teams, scores: $scores, turn: $turn, usedWords: $usedWords, usedWordSets: $usedWordSets, duration: $duration, wordsToWin: $wordsToWin, lastWord: $lastWord)';
  }

  @override
  bool operator ==(covariant AliasData other) {
    if (identical(this, other)) return true;

    return listEquals(other.teams, teams) &&
        listEquals(other.scores, scores) &&
        other.turn == turn &&
        setEquals(other.usedWords, usedWords) &&
        listEquals(other.usedWordSets, usedWordSets) &&
        other.duration == duration &&
        other.wordsToWin == wordsToWin &&
        other.lastWord == lastWord;
  }

  @override
  int get hashCode {
    return teams.hashCode ^
        scores.hashCode ^
        turn.hashCode ^
        usedWords.hashCode ^
        usedWordSets.hashCode ^
        duration.hashCode ^
        wordsToWin.hashCode ^
        lastWord.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teams': teams,
      'scores': scores,
      'turn': turn,
      'usedWords': usedWords.toList(),
      'usedWordSets': usedWordSets,
      'duration': duration,
      'wordsToWin': wordsToWin,
      'lastWord': lastWord,
    };
  }
}
