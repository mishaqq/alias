import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../providers/game_model_provider.dart';
import 'count_page.dart';

class GuessingPage extends ConsumerStatefulWidget {
  const GuessingPage({super.key});

  @override
  ConsumerState<GuessingPage> createState() => _GuessingPageState();
}

class _GuessingPageState extends ConsumerState<GuessingPage> {
  late final CountDownController _countDownController;
  @override
  void initState() {
    super.initState();
    _countDownController = CountDownController();
  }

  Map<String, int> roundWords = {};

  @override
  Widget build(BuildContext context) {
    String guessingWord = ref.read(gameProvider.notifier).selectRandomWord();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CircularCountDownTimer(
              duration: ref.read(gameProvider).duration,
              initialDuration: 0,
              controller: _countDownController,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Colors.purpleAccent[100]!,
              fillGradient: null,
              backgroundColor: Color.fromRGBO(252, 252, 252, 1),
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 33.0,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: true,
              isTimerTextShown: true,
              autoStart: true,
              onStart: () {
                //debugPrint('Countdown Started');
              },
              onComplete: () {
                if (ref.read(gameProvider).lastWord) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => CustomDialog(
                      teams: ref.read(gameProvider).teams,
                      lastWord: guessingWord,
                      roundWords: roundWords,
                    ),
                  );
                } else {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountPage(
                            raundWorlds: roundWords, nameOfLastTeam: ""),
                      ));
                }

                //Navigator.pop(context);
                //Navigator.push(
                //    context,
                //    MaterialPageRoute(
                //      builder: (context) => CountPage(raundWorlds: roundWords),
                //    ));
              },
              onChange: (String timeStamp) {
                // debugPrint('Countdown Changed $timeStamp');
              },
            ),
            Text(guessingWord),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                ref
                    .read(gameProvider.notifier)
                    .addUsedWord(guessingWord); // save used word
                roundWords[guessingWord] = 1; // save this round words
              },
              child: Text("Positive"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                ref.read(gameProvider.notifier).addUsedWord(guessingWord);
                roundWords[guessingWord] = 0;
              },
              child: Text("Negative"),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final List<String> teams;
  final String lastWord;
  final Map<String, int> roundWords;
  const CustomDialog(
      {super.key,
      required this.teams,
      required this.lastWord,
      required this.roundWords});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Who got the last word - $lastWord?"),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 45 * teams.length < MediaQuery.of(context).size.height
                ? (45 * (teams.length + 1)).toDouble()
                : MediaQuery.of(context).size.height,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: teams.length + 1,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    if (index == teams.length) {
                      roundWords[lastWord] = 0;
                    } else {
                      roundWords[lastWord] = 1;
                    }

                    Navigator.popUntil(context, ModalRoute.withName('/score'));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountPage(
                            raundWorlds: roundWords,
                            nameOfLastTeam:
                                index == teams.length ? "Nobody" : teams[index],
                          ),
                        ));
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
