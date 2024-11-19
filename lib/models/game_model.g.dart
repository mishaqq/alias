// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AliasDataImpl _$$AliasDataImplFromJson(Map<String, dynamic> json) =>
    _$AliasDataImpl(
      teams: (json['teams'] as List<dynamic>).map((e) => e as String).toList(),
      avatars:
          (json['avatars'] as List<dynamic>).map((e) => e as String).toList(),
      scores: (json['scores'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      turn: (json['turn'] as num).toInt(),
      usedWords:
          (json['usedWords'] as List<dynamic>).map((e) => e as String).toSet(),
      setsNames:
          (json['setsNames'] as List<dynamic>).map((e) => e as String).toList(),
      duration: (json['duration'] as num).toInt(),
      wordsToWin: (json['wordsToWin'] as num).toInt(),
      lastWord: json['lastWord'] as bool,
    );

Map<String, dynamic> _$$AliasDataImplToJson(_$AliasDataImpl instance) =>
    <String, dynamic>{
      'teams': instance.teams,
      'avatars': instance.avatars,
      'scores': instance.scores,
      'turn': instance.turn,
      'usedWords': instance.usedWords.toList(),
      'setsNames': instance.setsNames,
      'duration': instance.duration,
      'wordsToWin': instance.wordsToWin,
      'lastWord': instance.lastWord,
    };
