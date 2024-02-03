import 'package:flutter_riverpod/flutter_riverpod.dart';

final setsProvider =
    StateNotifierProvider<SetsProviderNotifier, List<String>>((ref) {
  return SetsProviderNotifier();
});

class SetsProviderNotifier extends StateNotifier<List<String>> {
  SetsProviderNotifier() : super([]);

  void updateSelection(int index, bool isSelected) {}
}
