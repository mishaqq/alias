import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/game_model.dart';

class GameNotifier extends StateNotifier<AliasData> {
  GameNotifier(super.state);

  void updateTeams(int index, String name) {
    final updatedTeams = List<String>.from(state.teams);
    updatedTeams[index] = name;

    state = state.copyWith(teams: updatedTeams);
  }

  void addTeam(String name) {
    final updatedTeams = List<String>.from(state.teams);
    updatedTeams.add(name);

    final updatedScores = List<int>.from(state.scores);
    updatedScores.add(0);

    state = state.copyWith(teams: updatedTeams, scores: updatedScores);
  }

  void reset() {
    state = state.copyWith(
        teams: ["Super Mario", "Not Ready yet"], scores: [0, 0], turn: 0);
  }
}
