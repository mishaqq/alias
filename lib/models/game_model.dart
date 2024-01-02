// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AliasData {
  final List<String> teams;
  final List<int> scores;
  final int turn;
  AliasData({
    required this.teams,
    required this.scores,
    required this.turn,
  });

  AliasData copyWith({
    List<String>? teams,
    List<int>? scores,
    int? turn,
  }) {
    return AliasData(
      teams: teams ?? this.teams,
      scores: scores ?? this.scores,
      turn: turn ?? this.turn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teams': teams,
      'scores': scores,
      'turn': turn,
    };
  }

  void f() {
    print("i did it");
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'AliasData(teams: $teams, scores: $scores, turn: $turn)';

  @override
  bool operator ==(covariant AliasData other) {
    if (identical(this, other)) return true;

    return listEquals(other.teams, teams) &&
        listEquals(other.scores, scores) &&
        other.turn == turn;
  }

  @override
  int get hashCode => teams.hashCode ^ scores.hashCode ^ turn.hashCode;

  factory AliasData.fromMap(Map<String, dynamic> map) {
    return AliasData(
      teams: List<String>.from(map['teams'] as List<String>),
      scores: List<int>.from(map['scores'] as List<int>),
      turn: map['turn'] as int,
    );
  }

  factory AliasData.fromJson(String source) =>
      AliasData.fromMap(json.decode(source) as Map<String, dynamic>);
}
