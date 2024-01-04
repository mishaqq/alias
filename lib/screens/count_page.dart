import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

class CountPage extends ConsumerWidget {
  final Map<String, int> raundWorlds;
  const CountPage(this.raundWorlds, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Team: ${game.teams[game.turn]}",
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemCount: raundWorlds.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  raundWorlds.keys.toList()[index],
                ),
                trailing: Text(
                  raundWorlds.values.toList()[index].toString(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
