import 'dart:math';

import 'package:alias/core/constants.dart';
import 'package:alias/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> initTeams(Ref ref) {
  final random = Random();
  Locale curLocale = ref.read(localeProvider);
  final List<String> localizedTeamList =
      teamLocalizationModel.localizedTeamList[curLocale]!;
  Set<String> initialTeams = {};

  while (initialTeams.length < 2) {
    String word = localizedTeamList[random.nextInt(localizedTeamList.length)];
    initialTeams.add(word);
  }

  return initialTeams.toList();
}

List<String> initTeamsAvatars() {
  final random = Random();
  Set<String> initialTeamsAvatars = {};

  while (initialTeamsAvatars.length < 2) {
    String image = images[random.nextInt(images.length)];
    initialTeamsAvatars.add(image);
  }

  return initialTeamsAvatars.toList();
}

String initExanpleWords(List<String> allWords, {int wordsQuantity = 3}) {
  final random = Random();
  String initialWords = "";
  int wordsQ = wordsQuantity;
  while (wordsQ != 0) {
    String word = allWords[random.nextInt(allWords.length)];
    if (initialWords.contains(word)) continue;
    initialWords += initialWords == "" ? word : ", $word";
    wordsQ--;
  }
  return initialWords;
}
