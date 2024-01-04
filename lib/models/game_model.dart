// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AliasData {
  final List<String> teams;
  final List<int> scores;
  final int turn;
  final Set<String> usedWords;
  final List<String>
      usedWordSets; // array of words, that are used in the current game
  AliasData({
    required this.teams,
    required this.scores,
    required this.turn,
    required this.usedWords,
    required this.usedWordSets,
  });

  AliasData copyWith({
    List<String>? teams,
    List<int>? scores,
    int? turn,
    Set<String>? usedWords,
    List<String>? usedWordSets,
  }) {
    return AliasData(
      teams: teams ?? this.teams,
      scores: scores ?? this.scores,
      turn: turn ?? this.turn,
      usedWords: usedWords ?? this.usedWords,
      usedWordSets: usedWordSets ?? this.usedWordSets,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teams': teams,
      'scores': scores,
      'turn': turn,
      'usedWords': usedWords.toList(),
      'usedWordSets': usedWordSets,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AliasData(teams: $teams, scores: $scores, turn: $turn, usedWords: $usedWords, usedWordSets: $usedWordSets)';
  }

  @override
  bool operator ==(covariant AliasData other) {
    if (identical(this, other)) return true;

    return listEquals(other.teams, teams) &&
        listEquals(other.scores, scores) &&
        other.turn == turn &&
        setEquals(other.usedWords, usedWords) &&
        listEquals(other.usedWordSets, usedWordSets);
  }

  @override
  int get hashCode {
    return teams.hashCode ^
        scores.hashCode ^
        turn.hashCode ^
        usedWords.hashCode ^
        usedWordSets.hashCode;
  }
}
