import 'package:alias/providers/locale_provider.dart';
import 'package:alias/screens/rules.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import '../providers/game_model_provider.dart';
import 'count_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO
// add popUp "you cant go back"
class GuessingPage extends ConsumerStatefulWidget {
  const GuessingPage({super.key});

  @override
  ConsumerState<GuessingPage> createState() => _GuessingPageState();
}

class _GuessingPageState extends ConsumerState<GuessingPage> {
  late final CountDownController _countDownController;
  late final CardSwiperController controller;
  late AudioPlayer player;
  int plus = 0;
  int minus = 0;
  @override
  void initState() {
    _countDownController = CountDownController();
    controller = CardSwiperController();
    player = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  Map<String, int> roundWords = {};

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    String guessingWord = ref.read(gameProvider.notifier).selectRandomWord();
    List<Container> cards = [
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 237, 255),
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width * 0.035),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 30, 62, 187),
              offset: Offset(0.0, 5.0), //(x,y)
              blurRadius: 15.0,
            ),
          ],
        ),
        width: w * 0.7,
        height: w * 0.7,
        padding: EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: Text(
          guessingWord,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 7,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 24.sp, // fontSize of the guessing word
                height: 1.1,
              ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 237, 255),
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(w * 0.035),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 30, 62, 187),
              offset: Offset(0.0, 5.0), //(x,y)
              blurRadius: 15.0,
            ),
          ],
        ),
        width: w * 0.3,
        height: w * 0.3,
        alignment: Alignment.center,
        child: const Text(""),
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
            top: h * 0.06,
            left: w * 0.04,
            right: w * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 237, 255),
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(w * 0.035),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 30, 62, 187),
                      offset: Offset(0.0, 4.0), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                width: w * 0.8,
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
                        icon: Icon(
                          Icons.pause_outlined,
                          color: Colors.black,
                        ),
                        splashColor: Colors.grey,
                        splashRadius: 30,
                        iconSize: 22.sp,
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
                      SizedBox(width: w * 0.175),
                      CircularCountDownTimer(
                        duration: ref.read(gameProvider).duration,
                        initialDuration: 0,
                        controller: _countDownController,
                        width: h * 0.065,
                        height: h * 0.065,
                        ringColor: Color.fromARGB(255, 255, 221, 149),
                        ringGradient: null,
                        fillColor: Color.fromARGB(255, 255, 174, 0),
                        fillGradient: null,
                        backgroundColor: Color.fromARGB(255, 248, 237, 255),
                        backgroundGradient: null,
                        strokeWidth: w * 0.009,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                            fontSize: 18.sp,
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
                        onComplete: () async {
                          Locale curLocale = ref.read(localeProvider);
                          await player.setVolume(1);
                          switch (curLocale.languageCode) {
                            case "en":
                              await player
                                  .setAsset('assets/audio/lastWordEN.mp3');
                              break;
                            case "uk":
                              await player
                                  .setAsset('assets/audio/lastWordUK.mp3');
                              break;
                            default:
                              await player
                                  .setAsset('assets/audio/lastWordEN.mp3');
                              break;
                          }

                          player.play();

                          if (ref.read(gameProvider).lastWord) {
                            ref.read(gameProvider.notifier).addUsedWord(
                                  guessingWord,
                                );
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => WillPopScope(
                                child: CustomDialog(
                                  teams: ref.read(gameProvider).teams,
                                  lastWord: guessingWord,
                                  roundWords: roundWords,
                                  avatars: ref.read(gameProvider).avatars,
                                  //TODO
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
                      const Spacer(),
                      Padding(
                        padding: game.isNoMinusPoints
                            ? EdgeInsets.only(
                                right: w * 0.03,
                              )
                            : EdgeInsets.zero, //(8.0),
                        child: Text(
                          !game.isNoMinusPoints ? "-$minus|$plus+" : "+$plus",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 20.sp,
                                  ),
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: h * 0.03),
                    child: SizedBox(
                      width: w * 0.8,
                      height: w * 0.8,
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
                        cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) {
                          return cards[index];
                        },
                        onSwipe: (previousIndex, currentIndex, direction) {
                          if (direction == CardSwiperDirection.right) {
                            player.setAsset('assets/audio/correct.mp3');
                            player.play();

                            ref
                                .read(gameProvider.notifier)
                                .addUsedWord(guessingWord); // save used word
                            roundWords[guessingWord] =
                                1; // save this round words
                            plus++;
                          } else {
                            player.setAsset('assets/audio/wrong.mp3');
                            player.play();

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
                      bottom: h * 0.08,
                      left: w * 0.06,
                      right: w * 0.06,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: w * 0.23,
                          height: w * 0.23,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor:
                                  Color.fromARGB(255, 255, 221, 149),
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
                          height: w * 0.23,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor:
                                  Color.fromARGB(255, 255, 221, 149),
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
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final List<String> teams;
  final List<String> avatars;
  final String lastWord;
  final Map<String, int> roundWords;
  final int lastWordScore;
  final bool isFromScore;
  const CustomDialog({
    super.key,
    required this.teams,
    required this.lastWord,
    required this.roundWords,
    required this.avatars,
    this.lastWordScore = 1,
    this.isFromScore = false,
  });

  void _handleTheLastWord(BuildContext context, int index, bool isNobodyWon) {
    roundWords[lastWord] = isNobodyWon ? 0 : lastWordScore;
    // TODO int.parse(lastWordScore);

    Navigator.popUntil(context, ModalRoute.withName('/score'));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountPage(
          raundWorlds: roundWords,
          nameOfLastTeam: isNobodyWon ? 'Nobody' : teams[index],
        ),
      ),
    );
  }

  void _handleTheLastWordFromScore(BuildContext context, int index) {
    Navigator.of(context).pop(index == teams.length ? "Nobody" : teams[index]);
  }

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
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 237, 255),
          border: Border.all(width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(w * 0.035),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 5.0), //(x,y)
              blurRadius: 15.0,
            ),
          ],
        ),
        width: w * 0.85,
        child: Padding(
          padding: EdgeInsets.only(
            left: h * 0.015,
            right: h * 0.015,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: h * 0.015, bottom: w * 0.03),
                  child: Text(
                    lastWord,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 24.sp,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                  )),
              const Divider(
                height: 0,
                thickness: 2,
                color: Colors.black,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: h * 0.5,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: w * 0.02),
                  physics: BouncingScrollPhysics(),
                  itemCount: teams.length + 1,
                  itemBuilder: (context, index) => index != teams.length
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.grey[300],
                            onTap: () {
                              if (!isFromScore) {
                                _handleTheLastWord(context, index, false);
                              } else {
                                _handleTheLastWordFromScore(context, index);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.009),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: w * 0.03),
                                        child: CircleAvatar(
                                          child: ClipOval(
                                            child: Image.asset(avatars[index],
                                                fit: BoxFit.cover),
                                          ),
                                          radius: w * 0.058,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          teams[index],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 18.sp,
                                                height: 1.1,
                                              ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (!isFromScore) {
                                            _handleTheLastWord(
                                                context, index, false);
                                          } else {
                                            _handleTheLastWordFromScore(
                                                context, index);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(
                                            side: BorderSide(width: 2),
                                          ),
                                          padding: EdgeInsets.all(w * 0.02),
                                          shadowColor: Colors.black54,
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 221, 149),
                                          overlayColor: const Color.fromARGB(
                                              255, 255, 174, 0),
                                        ),
                                        child: Text(
                                          "+${lastWordScore}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 18.sp,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  index != teams.length
                                      ? Padding(
                                          padding:
                                              EdgeInsets.only(top: h * 0.009),
                                          child: const DottedLine(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.center,
                                            lineThickness: 2.0,
                                            dashLength: 8.0,
                                            dashColor: Colors.black,
                                            dashGapLength: 10,
                                            dashGapColor: Colors.transparent,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.grey[300],
                            onTap: () {
                              if (!isFromScore) {
                                _handleTheLastWord(context, index, true);
                              } else {
                                _handleTheLastWordFromScore(context, index);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.009),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: w * 0.03),
                                        child: CircleAvatar(
                                          radius: w * 0.058,
                                          backgroundColor: const Color.fromRGBO(
                                              194, 193, 193, 1),
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/images/fish_dead.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!.nobody,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 18.sp,
                                              ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (!isFromScore) {
                                            _handleTheLastWord(
                                                context, index, true);
                                          } else {
                                            _handleTheLastWordFromScore(
                                                context, index);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(
                                            side: BorderSide(width: 2),
                                          ),
                                          padding: EdgeInsets.all(w * 0.02),
                                          shadowColor: Colors.black54,
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 221, 149),
                                          overlayColor: const Color.fromARGB(
                                              255, 255, 174, 0),
                                        ),
                                        child: Text(
                                          "0",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 18.sp,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  index != teams.length
                                      ? Padding(
                                          padding:
                                              EdgeInsets.only(top: h * 0.009),
                                          child: const DottedLine(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.center,
                                            lineThickness: 2.0,
                                            dashLength: 8.0,
                                            dashColor: Colors.black,
                                            dashGapLength: 10,
                                            dashGapColor: Colors.transparent,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 2,
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(top: w * 0.03, bottom: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.wordForAll,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18.sp,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    SizedBox(
                      width: w * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RulesPage(
                              selected: 1,
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.info_outline,
                        size: 26.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          size: MediaQuery.of(context).size.width * 0.24,
          color: Colors.black54,
        ),
      ),
    );
  }
}
