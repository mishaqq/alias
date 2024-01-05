import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

// ignore: must_be_immutable
class CountPage extends ConsumerStatefulWidget {
  Map<String, int> raundWorlds;
  CountPage({super.key, required this.raundWorlds});

  @override
  ConsumerState<CountPage> createState() => _CountPageState();
}

class _CountPageState extends ConsumerState<CountPage> {
  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Team: ${game.teams[game.turn]}",
          ),
          Text(
            "Play to ${game.wordsToWin}",
          ),
          Flexible(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 48),
              child: Container(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.raundWorlds.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        String key = widget.raundWorlds.keys.toList()[index];
                        if (widget.raundWorlds[key] == 1) {
                          widget.raundWorlds[key] = 0;
                        } else {
                          widget.raundWorlds[key] = 1;
                        }
                      });
                      print(widget.raundWorlds.values.toList());
                    },
                    child: ListTile(
                        title: Text(
                          widget.raundWorlds.keys.toList()[index],
                        ),
                        trailing: widget.raundWorlds.values.toList()[index] == 1
                            ? Icon(
                                Icons.brightness_1,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.brightness_1_outlined,
                                color: Colors.red,
                              )
                        //Text(
                        //raundWorlds.values.toList()[index].toString(),
                        // ),
                        ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              child: ElevatedButton(
            onPressed: () {
              int roundScore = 0;
              for (int value in widget.raundWorlds.values) {
                if (value == 0) {
                  roundScore--;
                } else {
                  roundScore++;
                }
              }

              if (roundScore > 0) {
                ref
                    .read(gameProvider.notifier)
                    .updateScore(ref.read(gameProvider).turn, roundScore);
              }

              ref.read(gameProvider.notifier).nextTurn();
              Navigator.pop(context);
            },
            child: Text("Done"),
          ))
        ],
      ),
    );
  }
}
