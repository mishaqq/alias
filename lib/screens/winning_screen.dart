// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:alias/providers/game_model_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WinningPage extends ConsumerStatefulWidget {
  final List<String> winners;
  const WinningPage({
    super.key,
    required this.winners,
  });

  @override
  ConsumerState<WinningPage> createState() => _WinningPageState();
}

class _WinningPageState extends ConsumerState<WinningPage>
    with TickerProviderStateMixin {
  late ConfettiController _controllerBottomCenter;
  late AnimationController controller;
  late Animation<double> animationW;

  String whoWins(List<String> winners) {
    if (winners.length == 1) {
      return "${winners[0]} ${AppLocalizations.of(context)!.oneWinner}";
    }
    if (winners.length == 2) {
      return "${winners[0]} і ${winners[1]} ${AppLocalizations.of(context)!.twoWinners}";
    }
    if (winners.length == ref.read(gameProvider).teams.length) {
      return AppLocalizations.of(context)!.moreThenTwoWinners;
    }
    String winnersString = " ";
    winners.forEach((w) => winnersString += "$w, ");
    return "$winnersString ${AppLocalizations.of(context)!.twoWinners}";
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    controller = new AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(() => setState(() {}));
    animationW = Tween(begin: -500.0, end: 0.0).animate(controller);

    controller.forward();
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter.play();
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        ref.read(gameProvider.notifier).reset();
        await ref.read(gameProvider.notifier).deleteFromPrefs(context);

        // ignore: use_build_context_synchronously
        Navigator.popUntil(context, (route) => route.isFirst);
        //TO DO handle end game
        return false;
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 112, 150, 236),
                Color.fromARGB(255, 52, 104, 192)
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: h * 0.35,
              left: w * 0.075,
              right: w * 0.075,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: Offset(animationW.value, 0),
                        child: Draggable(
                          onDraggableCanceled: (velocity, offset) async {
                            ref.read(gameProvider.notifier).reset();
                            await ref
                                .read(gameProvider.notifier)
                                .deleteFromPrefs(context);

                            // ignore: use_build_context_synchronously
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            //TO DO handle end game
                          },
                          feedback: Material(
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 248, 237, 255),
                                border: Border.all(width: h * 0.0024),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(h * 0.018),
                                ),
                              ),
                              width: w * 0.8,
                              height: h * 0.32,
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: w * 0.02),
                                child: Text(
                                  whoWins(widget.winners),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: w *
                                            0.07, // fontSize of the guessing word
                                      ),
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 237, 255),
                              border: Border.all(width: h * 0.0024),
                              borderRadius: BorderRadius.all(
                                Radius.circular(h * 0.018),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: w * 0.8,
                            height: h * 0.32,
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.02),
                              child: Text(
                                whoWins(widget.winners),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: w *
                                          0.07, // fontSize of the guessing word
                                    ),
                              ),
                            ),
                          ),
                          childWhenDragging: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 237, 255),
                              border: Border.all(width: h * 0.0024),
                              borderRadius: BorderRadius.all(
                                Radius.circular(h * 0.018),
                              ),
                            ),
                            alignment: Alignment.center,
                            width: w * 0.8,
                            height: h * 0.32,
                            child: Text(
                              "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: w *
                                        0.047, // fontSize of the guessing word
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: h * 0.01,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ConfettiWidget(
                              confettiController: _controllerBottomCenter,
                              blastDirection: -pi / 2.7,
                              emissionFrequency: 0.01,
                              numberOfParticles: 50,
                              maxBlastForce: 100,
                              minBlastForce: 30,
                              gravity: 0.2,
                              shouldLoop: true,
                            ),
                            Spacer(),
                            ConfettiWidget(
                              confettiController: _controllerBottomCenter,
                              blastDirection: -pi / 1.5,
                              emissionFrequency: 0.01,
                              numberOfParticles: 50,
                              maxBlastForce: 100,
                              minBlastForce: 30,
                              gravity: 0.2,
                              shouldLoop: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
