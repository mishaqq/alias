// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';
part 'game_model.g.dart';

@freezed
class AliasData with _$AliasData {
  const factory AliasData({
    required List<String> teams,
    required List<String> avatars,
    required List<int> scores,
    required int turn,
    required Set<String> usedWords,
    required List<String> setsNames,
    required int duration,
    required int wordsToWin,
    required bool lastWord,
    required bool isNoMinusPoints,
  }) = _AliasData;

  factory AliasData.fromJson(Map<String, dynamic> json) =>
      _$AliasDataFromJson(json);
}
