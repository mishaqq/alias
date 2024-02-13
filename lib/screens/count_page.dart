// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../providers/game_model_provider.dart';

// ignore: must_be_immutable
class CountPage extends ConsumerStatefulWidget {
  Map<String, int> raundWorlds;
  String nameOfLastTeam;

  CountPage({
    super.key,
    required this.raundWorlds,
    required this.nameOfLastTeam,
  });

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
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.raundWorlds.length,
                  itemBuilder: (context, index) {
                    if (index == widget.raundWorlds.length - 1 &&
                        game.lastWord) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(
                            thickness: 3,
                            color: Colors.black,
                            height: 3,
                          ),
                          Text("Word for all"),
                          GestureDetector(
                            onTap: () async {
                              widget.nameOfLastTeam = (await openDialog())!;

                              setState(() {
                                String key =
                                    widget.raundWorlds.keys.toList()[index];
                                if (widget.nameOfLastTeam == "Nobody") {
                                  widget.raundWorlds[key] = 0;
                                } else {
                                  widget.raundWorlds[key] = 1;
                                }
                              });
                              //   String key =
                              //       widget.raundWorlds.keys.toList()[index];
                              //   if (widget.raundWorlds[key] == 1) {
                              //     widget.raundWorlds[key] = 0;
                              //   } else {
                              //     widget.raundWorlds[key] = 1;
                              //   }
                              //print(widget.raundWorlds.values.toList());
                            },
                            child: ListTile(
                                title: Text(
                                  widget.raundWorlds.keys.toList()[index],
                                ),
                                trailing: widget.raundWorlds.values
                                            .toList()[index] ==
                                        1
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.radio_button_unchecked_outlined,
                                        color: Colors.red,
                                      )
                                //Text(
                                //raundWorlds.values.toList()[index].toString(),
                                // ),
                                ),
                          ),
                        ],
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            String key =
                                widget.raundWorlds.keys.toList()[index];
                            if (widget.raundWorlds[key] == 1) {
                              widget.raundWorlds[key] = 0;
                            } else {
                              widget.raundWorlds[key] = 1;
                            }
                          });
                        },
                        child: ListTile(
                            title: Text(
                              widget.raundWorlds.keys.toList()[index],
                            ),
                            trailing:
                                widget.raundWorlds.values.toList()[index] == 1
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.radio_button_unchecked_outlined,
                                        color: Colors.red,
                                      )
                            //Text(
                            //raundWorlds.values.toList()[index].toString(),
                            // ),
                            ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Flexible(
              child: ElevatedButton(
            onPressed: () {
              // calculating the score
              int roundScore = 0;
              //print(widget.raundWorlds);
              for (int i = 0;
                  i <
                      (game.lastWord
                          ? widget.raundWorlds.values.toList().length - 1
                          : widget.raundWorlds.values.toList().length);
                  i++) {
                // ignore: unrelated_type_equality_checks
                if (widget.raundWorlds.values.toList()[i] == 0) {
                  roundScore--;
                } else {
                  roundScore++;
                }
              }

              // for (int value in widget.raundWorlds.values) {
              //   if (value == 0) {
              //     roundScore--;
              //   } else {
              //     roundScore++;
              //   }
              // }

              // team is getting the points
              if (roundScore > 0) {
                ref
                    .read(gameProvider.notifier)
                    .updateScore(ref.read(gameProvider).turn, roundScore);
              }

              //last team gets the point
              if (widget.nameOfLastTeam != "Nobody" && game.lastWord) {
                ref
                    .read(gameProvider.notifier)
                    .updateScore(game.teams.indexOf(widget.nameOfLastTeam), 1);
              }

              //next turn
              ref.read(gameProvider.notifier).nextTurn();
              ref.read(gameProvider.notifier).winCheck(context);
              //Navigator.pop(context);
            },
            child: Text("Done"),
          ))
        ],
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => CustomDialogScore(
          teams: ref.read(gameProvider).teams,
        ),
      );
}

class CustomDialogScore extends StatelessWidget {
  final List<String> teams;

  const CustomDialogScore({
    super.key,
    required this.teams,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 45 * teams.length < MediaQuery.of(context).size.height
                ? (45 * (teams.length + 1)).toDouble()
                : MediaQuery.of(context).size.height,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: teams.length + 1,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(index == teams.length ? "Nobody" : teams[index]);
                  },
                  child: Text(
                    index == teams.length ? "Nobody" : teams[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
