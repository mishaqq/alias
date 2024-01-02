import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

class ScorePage extends ConsumerWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Next turn: ${game.teams[game.turn]}",
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemCount: game.teams.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  game.teams[index],
                ),
                trailing: Text(
                  game.scores[index].toString(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(gameProvider.notifier).addTeam("Suki");
            },
            child: Text("Add Team"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(gameProvider.notifier).reset();
            },
            child: Text("Reset"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/guessing');
              ref
                  .read(gameProvider.notifier)
                  .nextTurn(); // move to guessing screen or score counting screen
            },
            child: Text("Start next round"),
          ),
        ],
      ),
    );
  }
}
