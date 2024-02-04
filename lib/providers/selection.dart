import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// Providers to save the state of Settings Page
///
final isSelectedProvider =
    StateNotifierProvider<SelectionNotifier, List<bool>>((ref) {
  return SelectionNotifier();
});

class SelectionNotifier extends StateNotifier<List<bool>> {
  SelectionNotifier() : super([false, false, true, false, false]);

  void updateSelection(int index, bool isSelected) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) isSelected else false
    ];
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(20);

  void setValue(int val) {
    state = val;
  }
}
