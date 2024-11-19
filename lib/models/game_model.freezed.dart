// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AliasData _$AliasDataFromJson(Map<String, dynamic> json) {
  return _AliasData.fromJson(json);
}

/// @nodoc
mixin _$AliasData {
  List<String> get teams => throw _privateConstructorUsedError;
  List<String> get avatars => throw _privateConstructorUsedError;
  List<int> get scores => throw _privateConstructorUsedError;
  int get turn => throw _privateConstructorUsedError;
  Set<String> get usedWords => throw _privateConstructorUsedError;
  List<String> get setsNames => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  int get wordsToWin => throw _privateConstructorUsedError;
  bool get lastWord => throw _privateConstructorUsedError;

  /// Serializes this AliasData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AliasData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AliasDataCopyWith<AliasData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AliasDataCopyWith<$Res> {
  factory $AliasDataCopyWith(AliasData value, $Res Function(AliasData) then) =
      _$AliasDataCopyWithImpl<$Res, AliasData>;
  @useResult
  $Res call(
      {List<String> teams,
      List<String> avatars,
      List<int> scores,
      int turn,
      Set<String> usedWords,
      List<String> setsNames,
      int duration,
      int wordsToWin,
      bool lastWord});
}

/// @nodoc
class _$AliasDataCopyWithImpl<$Res, $Val extends AliasData>
    implements $AliasDataCopyWith<$Res> {
  _$AliasDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AliasData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teams = null,
    Object? avatars = null,
    Object? scores = null,
    Object? turn = null,
    Object? usedWords = null,
    Object? setsNames = null,
    Object? duration = null,
    Object? wordsToWin = null,
    Object? lastWord = null,
  }) {
    return _then(_value.copyWith(
      teams: null == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatars: null == avatars
          ? _value.avatars
          : avatars // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scores: null == scores
          ? _value.scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<int>,
      turn: null == turn
          ? _value.turn
          : turn // ignore: cast_nullable_to_non_nullable
              as int,
      usedWords: null == usedWords
          ? _value.usedWords
          : usedWords // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      setsNames: null == setsNames
          ? _value.setsNames
          : setsNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      wordsToWin: null == wordsToWin
          ? _value.wordsToWin
          : wordsToWin // ignore: cast_nullable_to_non_nullable
              as int,
      lastWord: null == lastWord
          ? _value.lastWord
          : lastWord // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AliasDataImplCopyWith<$Res>
    implements $AliasDataCopyWith<$Res> {
  factory _$$AliasDataImplCopyWith(
          _$AliasDataImpl value, $Res Function(_$AliasDataImpl) then) =
      __$$AliasDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> teams,
      List<String> avatars,
      List<int> scores,
      int turn,
      Set<String> usedWords,
      List<String> setsNames,
      int duration,
      int wordsToWin,
      bool lastWord});
}

/// @nodoc
class __$$AliasDataImplCopyWithImpl<$Res>
    extends _$AliasDataCopyWithImpl<$Res, _$AliasDataImpl>
    implements _$$AliasDataImplCopyWith<$Res> {
  __$$AliasDataImplCopyWithImpl(
      _$AliasDataImpl _value, $Res Function(_$AliasDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AliasData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teams = null,
    Object? avatars = null,
    Object? scores = null,
    Object? turn = null,
    Object? usedWords = null,
    Object? setsNames = null,
    Object? duration = null,
    Object? wordsToWin = null,
    Object? lastWord = null,
  }) {
    return _then(_$AliasDataImpl(
      teams: null == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatars: null == avatars
          ? _value._avatars
          : avatars // ignore: cast_nullable_to_non_nullable
              as List<String>,
      scores: null == scores
          ? _value._scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<int>,
      turn: null == turn
          ? _value.turn
          : turn // ignore: cast_nullable_to_non_nullable
              as int,
      usedWords: null == usedWords
          ? _value._usedWords
          : usedWords // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      setsNames: null == setsNames
          ? _value._setsNames
          : setsNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      wordsToWin: null == wordsToWin
          ? _value.wordsToWin
          : wordsToWin // ignore: cast_nullable_to_non_nullable
              as int,
      lastWord: null == lastWord
          ? _value.lastWord
          : lastWord // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AliasDataImpl implements _AliasData {
  const _$AliasDataImpl(
      {required final List<String> teams,
      required final List<String> avatars,
      required final List<int> scores,
      required this.turn,
      required final Set<String> usedWords,
      required final List<String> setsNames,
      required this.duration,
      required this.wordsToWin,
      required this.lastWord})
      : _teams = teams,
        _avatars = avatars,
        _scores = scores,
        _usedWords = usedWords,
        _setsNames = setsNames;

  factory _$AliasDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AliasDataImplFromJson(json);

  final List<String> _teams;
  @override
  List<String> get teams {
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teams);
  }

  final List<String> _avatars;
  @override
  List<String> get avatars {
    if (_avatars is EqualUnmodifiableListView) return _avatars;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_avatars);
  }

  final List<int> _scores;
  @override
  List<int> get scores {
    if (_scores is EqualUnmodifiableListView) return _scores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scores);
  }

  @override
  final int turn;
  final Set<String> _usedWords;
  @override
  Set<String> get usedWords {
    if (_usedWords is EqualUnmodifiableSetView) return _usedWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_usedWords);
  }

  final List<String> _setsNames;
  @override
  List<String> get setsNames {
    if (_setsNames is EqualUnmodifiableListView) return _setsNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setsNames);
  }

  @override
  final int duration;
  @override
  final int wordsToWin;
  @override
  final bool lastWord;

  @override
  String toString() {
    return 'AliasData(teams: $teams, avatars: $avatars, scores: $scores, turn: $turn, usedWords: $usedWords, setsNames: $setsNames, duration: $duration, wordsToWin: $wordsToWin, lastWord: $lastWord)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AliasDataImpl &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._avatars, _avatars) &&
            const DeepCollectionEquality().equals(other._scores, _scores) &&
            (identical(other.turn, turn) || other.turn == turn) &&
            const DeepCollectionEquality()
                .equals(other._usedWords, _usedWords) &&
            const DeepCollectionEquality()
                .equals(other._setsNames, _setsNames) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.wordsToWin, wordsToWin) ||
                other.wordsToWin == wordsToWin) &&
            (identical(other.lastWord, lastWord) ||
                other.lastWord == lastWord));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_teams),
      const DeepCollectionEquality().hash(_avatars),
      const DeepCollectionEquality().hash(_scores),
      turn,
      const DeepCollectionEquality().hash(_usedWords),
      const DeepCollectionEquality().hash(_setsNames),
      duration,
      wordsToWin,
      lastWord);

  /// Create a copy of AliasData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AliasDataImplCopyWith<_$AliasDataImpl> get copyWith =>
      __$$AliasDataImplCopyWithImpl<_$AliasDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AliasDataImplToJson(
      this,
    );
  }
}

abstract class _AliasData implements AliasData {
  const factory _AliasData(
      {required final List<String> teams,
      required final List<String> avatars,
      required final List<int> scores,
      required final int turn,
      required final Set<String> usedWords,
      required final List<String> setsNames,
      required final int duration,
      required final int wordsToWin,
      required final bool lastWord}) = _$AliasDataImpl;

  factory _AliasData.fromJson(Map<String, dynamic> json) =
      _$AliasDataImpl.fromJson;

  @override
  List<String> get teams;
  @override
  List<String> get avatars;
  @override
  List<int> get scores;
  @override
  int get turn;
  @override
  Set<String> get usedWords;
  @override
  List<String> get setsNames;
  @override
  int get duration;
  @override
  int get wordsToWin;
  @override
  bool get lastWord;

  /// Create a copy of AliasData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AliasDataImplCopyWith<_$AliasDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
