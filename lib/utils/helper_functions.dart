import 'dart:math';

import 'package:alias/core/constants.dart';
import 'package:alias/dict/team_names.dart';

List<String> initTeams() {
  final random = Random();
  Set<String> initialTeams = {};

  while (initialTeams.length < 2) {
    String word = team_names[random.nextInt(team_names.length)];
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
