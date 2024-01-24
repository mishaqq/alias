// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alias/providers/game_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WinningPage extends ConsumerWidget {
  final List<String> winners;
  const WinningPage({
    super.key,
    required this.winners,
  });

  String whoWins(List<String> winners) {
    if (winners.length == 1) {
      return "${winners[0]} won!";
    }
    if (winners.length == 2) {
      return "${winners[0]} and ${winners[1]} won, so it is draw!";
    }
    return "Developer is stupid, so nobody wins today)";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              whoWins(winners),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(gameProvider.notifier).reset(context);
              },
              child: Text("End Game!"),
            ),
          ],
        ),
      ),
    );
  }
}
