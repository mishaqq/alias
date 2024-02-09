import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dict/word_sets.dart';

Map<String, List<String>> setsTable = {
  "basic": basic,
  "expert": expert,
  "ukr": ukr,
  "tworoots": tworoots,
};

///
/// Provider that saves and contains oll words that will be used in current game
///

final setsProvider =
    StateNotifierProvider<SetsProviderNotifier, List<String>>((ref) {
  return SetsProviderNotifier();
});

class SetsProviderNotifier extends StateNotifier<List<String>> {
  SetsProviderNotifier() : super([]);

  void updateWords(List<String> sets) {
    List<String> gameSets = [];
    for (String set in sets) {
      gameSets += setsTable[set]!;
    }

    state = gameSets;
  }
}
