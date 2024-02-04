import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/dialog.dart';
import '../main.dart';
import '../providers/game_model_provider.dart';

class ScorePage extends ConsumerWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);

    return WillPopScope(
      onWillPop: () async {
        return showAlertDialog(context, ref);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
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
                Navigator.pushNamed(context, '/guessing');
              },
              child: Text("Start next round"),
            ),
          ],
        ),
      ),
    );
  }
}
