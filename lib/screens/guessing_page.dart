import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';
import 'count_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GuessingPage extends ConsumerStatefulWidget {
  const GuessingPage({super.key});

  @override
  ConsumerState<GuessingPage> createState() => _GuessingPageState();
}

class _GuessingPageState extends ConsumerState<GuessingPage> {
  late final CountDownController _countDownController;
  late final CardSwiperController controller;
  int plus = 0;
  int minus = 0;
  @override
  void initState() {
    // hide status bar
    _countDownController = CountDownController();
    controller = CardSwiperController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values); // to re-show bars
  // }

  Map<String, int> roundWords = {};

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    String guessingWord = ref.read(gameProvider.notifier).selectRandomWord();
    List<Container> cards = [
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 237, 255),
          border: Border.all(width: h * 0.0024),
          borderRadius: BorderRadius.all(
            Radius.circular(h * 0.018),
          ),
        ),
        width: w * 0.3,
        height: h * 0.3,
        alignment: Alignment.center,
        child: Text(
          guessingWord,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 22.sp, // fontSize of the guessing word
              ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 237, 255),
          border: Border.all(width: h * 0.0024),
          borderRadius: BorderRadius.all(
            Radius.circular(h * 0.018),
          ),
        ),
        width: w * 0.3,
        height: h * 0.3,
        alignment: Alignment.center,
        child: Text(""),
      ),
    ];

    return Scaffold(
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
            top: h * 0.05,
            left: w * 0.04,
            right: w * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 237, 255),
                  border: Border.all(width: h * 0.0024),
                  borderRadius: BorderRadius.all(
                    Radius.circular(h * 0.018),
                  ),
                ),
                width: w * 0.92,
                height: h * 0.09,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: w * 0.03,
                    right: w * 0.03,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.pause_outlined),
                        splashColor: Colors.grey,
                        splashRadius: 30,
                        iconSize: w * 0.08,
                        onPressed: () {
                          _countDownController.isPaused.value
                              ? _countDownController.resume()
                              : _countDownController.pause();
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => WillPopScope(
                              child: Pause(c: _countDownController),
                              onWillPop: () {
                                _countDownController.resume();
                                return Future.value(true);
                              },
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      CircularCountDownTimer(
                        duration: ref.read(gameProvider).duration,
                        initialDuration: 0,
                        controller: _countDownController,
                        width: h * 0.065,
                        height: h * 0.065,
                        ringColor: Colors.grey[300]!,
                        ringGradient: null,
                        fillColor: Colors.black,
                        fillGradient: null,
                        backgroundColor: Color.fromARGB(255, 248, 237, 255),
                        backgroundGradient: null,
                        strokeWidth: w * 0.009,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                            fontSize: w * 0.044,
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
                              builder: (context) => WillPopScope(
                                child: CustomDialog(
                                  teams: ref.read(gameProvider).teams,
                                  lastWord: guessingWord,
                                  roundWords: roundWords,
                                ),
                                onWillPop: () => Future.value(false),
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountPage(
                                      raundWorlds: roundWords,
                                      nameOfLastTeam: ""),
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
                      Spacer(),
                      Text(
                        "$minus/$plus",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16.sp,
                            ),
                      ),
                      // Divider(
                      //   indent: w * 0.01,
                      //   endIndent: w * 0.01,
                      //   height: 0,
                      //   thickness: h * 0.002,
                      //   color: Colors.black,
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.25),
                child: SizedBox(
                  width: w * 0.8,
                  height: h * 0.32,
                  child: CardSwiper(
                    backCardOffset: Offset.zero,
                    padding: EdgeInsets.zero,
                    controller: controller,
                    allowedSwipeDirection:
                        const AllowedSwipeDirection.symmetric(
                      horizontal: true,
                      vertical: false,
                    ),
                    cardsCount: cards.length,
                    cardBuilder:
                        (context, index, percentThresholdX, percentThresholdY) {
                      return cards[index];
                    },
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (direction == CardSwiperDirection.right) {
                        ref
                            .read(gameProvider.notifier)
                            .addUsedWord(guessingWord); // save used word
                        roundWords[guessingWord] = 1; // save this round words
                        plus++;
                      } else {
                        ref
                            .read(gameProvider.notifier)
                            .addUsedWord(guessingWord);
                        roundWords[guessingWord] = 0;
                        minus++;
                      }
                      controller.moveTo(1);

                      setState(() {});

                      return true;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: h * 0.03,
                  left: w * 0.06,
                  right: w * 0.06,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: w * 0.23,
                      height: h * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 221, 149),
                        ),
                        onPressed: () {
                          controller.swipe(CardSwiperDirection.left);
                        },
                        child: Icon(
                          Icons.remove,
                          size: w * 0.07,
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: w * 0.23,
                      height: h * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 221, 149),
                        ),
                        onPressed: () {
                          controller.swipe(CardSwiperDirection.right);
                        },
                        child: Icon(
                          Icons.add,
                          size: w * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Color.fromARGB(255, 248, 237, 255),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: h * 0.0024),
        borderRadius: BorderRadius.all(
          Radius.circular(h * 0.018),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(h * 0.01),
            child: Text(
              "${AppLocalizations.of(context)!.whoGuessed} - $lastWord?",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                  ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height:
                (h * 0.058) * teams.length < MediaQuery.of(context).size.height
                    ? ((h * 0.058) * (teams.length + 1)).toDouble()
                    : MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: teams.length + 1,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.01, vertical: h * 0.002),
                child: SizedBox(
                  width: w * 0.85,
                  height: h * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,

                      shadowColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 255, 221,
                          149), // Color.fromARGB(255, 255, 221, 149),
                      foregroundColor: Colors.black, //TO FIX
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: MediaQuery.of(context).size.height * 0.0024),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              MediaQuery.of(context).size.height * 0.00),
                        ),
                      ),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {
                      if (index == teams.length) {
                        roundWords[lastWord] = 0;
                      } else {
                        roundWords[lastWord] = 1;
                      }

                      Navigator.popUntil(
                          context, ModalRoute.withName('/score'));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountPage(
                            raundWorlds: roundWords,
                            nameOfLastTeam:
                                index == teams.length ? "Nobody" : teams[index],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      index == teams.length
                          ? AppLocalizations.of(context)!.nobody
                          : teams[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 10.sp,
                          ),
                    ),
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

class Pause extends StatelessWidget {
  final CountDownController c;
  const Pause({
    super.key,
    required this.c,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        c.resume();
        Navigator.pop(context);
      },
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        icon: Icon(
          Icons.play_arrow_rounded,
          size: MediaQuery.of(context).size.width * 0.08,
        ),
      ),
    );
  }
}
