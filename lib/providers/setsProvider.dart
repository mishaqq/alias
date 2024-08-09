import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants.dart';

///
/// Provider that saves and contains all words that will be used in current game
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
