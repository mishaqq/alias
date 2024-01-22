import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../providers/game_model_provider.dart';

class TeamPage extends ConsumerWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    print(game.teams);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: game.teams.length,
              itemBuilder: (context, index) => ListTile(
                  title: Text(
                    game.teams[index],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      if (game.teams.length > 2) {
                        ref.read(gameProvider.notifier).deleteTeam(index);
                      }
                    },
                  )),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(gameProvider.notifier).addTeam();
            },
            child: Text("Add Team"),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     ref.read(gameProvider.notifier).reset(context);
          //   },
          //   child: Text("Reset"),
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/score');
            },
            child: Text("Start the game"),
          ),
        ],
      ),
    );
  }
}
