import 'dart:developer';

import 'package:alias/providers/game_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final oldSessionProvider =
    StateNotifierProvider<OldSessionNotifier, bool>((ref) {
  return OldSessionNotifier(false, ref);
});

class OldSessionNotifier extends StateNotifier<bool> {
  Ref ref;
  OldSessionNotifier(
    super.state,
    this.ref,
  );
  void updateOldGame(bool value) {
    state = value;
  }

  Future<void> oldGame() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    log("-------------------");
    log("old game: ${pref.getString(gameDataKey)}");
    state = pref.getString(gameDataKey) != null;
  }
}
