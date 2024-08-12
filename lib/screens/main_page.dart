import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

bool oldSesion = false;
late final CardSwiperController controller;

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // when the page loads it reads from the SP if there was an old session and saves it to the Game Provider state
    ref.read(gameProvider.notifier).oldGame();
    controller = CardSwiperController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    oldSesion = ref.watch(gameProvider).oldSesion;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
          "Аліас",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 35.sp, // fontSize of the guessing word
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
        child: Text(
          "Українською",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 30.sp, // fontSize of the guessing word
              ),
        ),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    width: w,
                    bottom: h * 0.75,
                    child: Image.asset(
                      "assets/images/cloud.png",
                      height: h * 0.11,
                    ),
                  ),
                  Positioned(
                    width: w,
                    bottom: h * 0.55,
                    left: w * 0.28,
                    child: Image.asset(
                      "assets/images/cloud.png",
                      height: h * 0.11,
                    ),
                  ),

                  Positioned(
                    bottom: h * 0.51,
                    right: w * 0.16,
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.25),
                      child: SizedBox(
                        width: w * 0.7,
                        height: h * 0.25,
                        child: CardSwiper(
                          backCardOffset: Offset.zero,
                          padding: EdgeInsets.zero,
                          controller: controller,
                          allowedSwipeDirection:
                              const AllowedSwipeDirection.symmetric(
                            horizontal: true,
                            vertical: true,
                          ),
                          cardsCount: cards.length,
                          cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) {
                            return cards[index];
                          },
                          onSwipe: (previousIndex, currentIndex, direction) {
                            setState(() {});
                            return true;
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: w,
                    top: h * 0.09,
                    left: w * 0.31,
                    child: Image.asset(
                      "assets/images/wow.png",
                      height: h * 0.30,
                    ),
                  ),
                  Positioned(
                    width: w,
                    bottom: h * 0.42,
                    right: w * 0.22,
                    child: Image.asset(
                      "assets/images/cloud.png",
                      height: h * 0.11,
                    ),
                  ),
                  Positioned(
                    width: w,
                    bottom: h * 0.005,
                    right: w * 0.42,
                    child: Image.asset(
                      "assets/images/fish_dead.png",
                      height: h * 0.08,
                    ),
                  ),
                  Positioned(
                    width: w,
                    bottom: h * 0.45,
                    left: w * 0.35,
                    child: Transform.scale(
                      scaleX: -1,
                      child: Transform.rotate(
                        angle: -320 / 360,
                        child: IgnorePointer(
                          child: Image.asset(
                            "assets/images/arrow_home.png",
                            height: h * 0.35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: w,
                    bottom: h * 0.45,
                    right: w * 0.36,
                    child: Transform.scale(
                      scaleX: 1,
                      child: Transform.rotate(
                        angle: -320 / 360,
                        child: IgnorePointer(
                          child: Image.asset(
                            "assets/images/arrow_home.png",
                            height: h * 0.35,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   left: w * 0.15,
                  //   top: h * 0.26,
                  //   bottom: h * 0.5,
                  //   child: Image.asset(
                  //     "assets/images/post_logo.png",
                  //     height: h * 0.2,
                  //     width: w,
                  //     scale: 1.3,
                  //   ),
                  // ),
                  if (oldSesion)
                    Positioned(
                      width: w,
                      bottom: h * 0.24,
                      left: w * 0.22,
                      child: Image.asset(
                        "assets/images/cat_shy.png",
                        height: h * 0.11,
                      ),
                    ),
                  if (oldSesion)
                    Positioned(
                      top: h * 0.50,
                      bottom: 0,
                      width: w,
                      child: Center(
                        child: SizedBox(
                          width: w * 0.8,
                          height: h * 0.063,
                          child: ElevatedButton(
                            onPressed: () async {
                              // fetches the data from SP to Game Provider
                              await ref
                                  .read(gameProvider.notifier)
                                  .readFormPrefs();

                              // makes a list of words for the current game
                              ref.read(gameProvider.notifier).makeGameWordSet(
                                  ref.read(gameProvider).setsNames);

                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/score');
                            },
                            child: Text("Продовжити",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(),
                  Positioned(
                    top: h * 0.64,
                    bottom: 0,
                    width: w,
                    child: Center(
                      child: SizedBox(
                        width: w * 0.8,
                        height: h * 0.063,
                        child: ElevatedButton(
                            onPressed: () async {
                              ref.read(gameProvider.notifier).reset();
                              Navigator.pushNamed(context, '/set_choosing');
                            },
                            child: Text("Нова гра",
                                style: Theme.of(context).textTheme.bodyMedium)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: h * 0.78,
                    bottom: 0,
                    width: w,
                    child: Center(
                      child: SizedBox(
                        width: w * 0.8,
                        height: h * 0.063,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, '/rules');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 248, 237, 255),
                            ),
                            child: Text("Правила",
                                style: Theme.of(context).textTheme.bodyMedium)),
                      ),
                    ),
                  ),
                  Positioned(
                    width: w,
                    bottom: h * 0.08,
                    left: w * 0.37,
                    child: IgnorePointer(
                      child: Image.asset(
                        "assets/images/datebaio.png",
                        height: h * 0.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
