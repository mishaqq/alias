import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../providers/game_model_provider.dart';

class TeamPage extends ConsumerWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: game.teams.length,
              itemBuilder: (context, index) => ListTile(
                  title: Text(
                    game.teams[index],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
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
            child: const Text("Add Team"),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     ref.read(gameProvider.notifier).reset(context);
          //   },
          //   child: Text("Reset"),
          // ),
          ElevatedButton(
            onPressed: () async {
              // TO DO
              // Add popup -- Old session will be deleated

              /// rewrites old session in SP
              await ref.read(gameProvider.notifier).writeToPrefs();

              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/score');
            },
            child: const Text("Start the game"),
          ),
        ],
      ),
    );
  }
}