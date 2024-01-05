import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
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
                print(roundWords);
                print(ref.read(gameProvider).usedWords);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountPage(raundWorlds: roundWords),
                    ));
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
