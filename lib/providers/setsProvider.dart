import 'dart:developer';

import 'package:alias/models/set_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants.dart';

///
/// Provider that saves and contains all words that will be used in current game
///

final wordsProvider =
    StateNotifierProvider<SetsProviderNotifier, List<String>>((ref) {
  return SetsProviderNotifier();
});

class SetsProviderNotifier extends StateNotifier<List<String>> {
  SetsProviderNotifier() : super([]);

  void updateWords(List<AliasSet> sets) {
    List<String> gameWords = [];
    log("Loaded sets to wordsProvider: ");
    for (AliasSet set in sets) {
      gameWords += set.contents;
      log(set.id);
    }

    state = gameWords;
  }
}
