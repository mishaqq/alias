import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

class ScorePage extends ConsumerWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    print(game.teams);
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
              physics: BouncingScrollPhysics(),
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
              ref.read(gameProvider.notifier).addTeam();
            },
            child: Text("Add Team"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(gameProvider.notifier).reset(context);
            },
            child: Text("Reset"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/guessing');
            },
            child: Text("Start next round"),
          ),
        ],
      ),
    );
  }
}
