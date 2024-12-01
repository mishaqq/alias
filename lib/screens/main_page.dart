import 'dart:developer';

import 'package:alias/core/constants.dart';
import 'package:alias/elements/cat_popup.dart';
import 'package:alias/providers/locale_provider.dart';
import 'package:alias/providers/oldSession_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typewritertext/typewritertext.dart';
import '../providers/game_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

bool oldSesion = false;
bool isCat = true;

late final CardSwiperController controller;
Map<int, Locale> languageMap = {
  1: const Locale('uk'),
  2: const Locale('en'),
};
Map<Locale, int> reverseLanguageMap = {
  const Locale('uk'): 1,
  const Locale('en'): 2,
};

class _MainPageState extends ConsumerState<MainPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightPosition;
  late AnimationController _controllerCat;
  late Animation<double> _catAnimationController;
  late OverlayPortalController overlayPortalController;
  late OverlayPortalController overlayPortalControllerLangChange;
  late Animation<double> _catAnimationControllerLangChange;
  late AnimationController _controllerCatLangChange;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    ref.read(oldSessionProvider.notifier).oldGame();
    controller = CardSwiperController();

    //init overlay controller
    overlayPortalController = OverlayPortalController();
    overlayPortalControllerLangChange = OverlayPortalController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // when the page loads it reads from the SP if there was an old session and saves it to the Game Provider state
      //oldSesion = await ref.read(gameProvider.notifier).oldGame();

      final List<Locale> systemLocales =
          View.of(context).platformDispatcher.locales;
      log(systemLocales.toString());
      await ref.read(localeProvider.notifier).initLocale(systemLocales);

      // Cat popUp animaiton

      // Initialize AnimationController
      _controllerCat = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      );

      // Define animations for top and left positions
      _catAnimationController = Tween<double>(
        begin: MediaQuery.of(context).size.height * -0.08,
        end: MediaQuery.of(context).size.height * 0.06,
      ).animate(
        CurvedAnimation(
          parent: _controllerCat,
          curve: Curves.easeIn,
        ),
      );

      //cat popUp animation routine
      isCat = await ref.read(localeProvider.notifier).ifCatPopup();

      // if languaage changed
      _controllerCatLangChange = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      );
      _catAnimationControllerLangChange = Tween<double>(
        begin: MediaQuery.of(context).size.height * 0.7,
        end: MediaQuery.of(context).size.height * 0.6,
      ).animate(
        CurvedAnimation(
          parent: _controllerCatLangChange,
          curve: Curves.easeIn,
        ),
      );
      if (isCat) {
        Future.delayed(
          const Duration(milliseconds: 2000),
          () => {
            overlayPortalController.show(),
            _controllerCat.forward(),
          },
        ).then((_) {
          return Future.delayed(
            const Duration(milliseconds: 6000),
            () => {
              _controllerCat.reverse().then((_) {
                overlayPortalController.hide();
              }),
            },
          );
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    // Initialize AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define animations for top and left positions
    _heightPosition = Tween<double>(
      begin: MediaQuery.of(context).size.height * 0.20,
      end: MediaQuery.of(context).size.height * 0.24,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation on build
    _controller.forward();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    oldSesion = ref.watch(oldSessionProvider);
    log(oldSesion.toString());
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    List<Container> cards = [
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
        height: h * 0.3,
        alignment: Alignment.center,
        child: Text(
          //AppLocalizations.of(context)!.understood,
          AppLocalizations.of(context)!.appTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 34.sp,
                // fontSize of the guessing word
                letterSpacing: -1,
              ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 237, 255),
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
        height: h * 0.3,
        alignment: Alignment.center,
        child: Text(
          "English",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 30.sp, // fontSize of the guessing word
                letterSpacing: 0,
              ),
        ),
      ),
    ];

    return Scaffold(
      body: OverlayPortal(
        controller: overlayPortalController,
        overlayChildBuilder: (context) => AnimatedBuilder(
          animation: _catAnimationController,
          builder: (context, child) {
            return LCatPopUp(
              text: AppLocalizations.of(context)!.catPopup,
              h: h,
              w: w,
              controller: _catAnimationController,
            );
          },
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
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
                    // Positioned(
                    //   width: w,
                    //   top: h * 0.35,
                    //   left: w * 0.28,
                    //   child: Image.asset(
                    //     "assets/images/cloud.png",
                    //     height: h * 0.11,
                    //   ),
                    // ),
                    Positioned(
                      width: w,
                      bottom: h * 0.45,
                      left: w * 0.34,
                      child: Transform.scale(
                        scaleX: -1,
                        child: Transform.rotate(
                          angle: -260 / 360,
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
                      right: w * 0.34,
                      child: Transform.scale(
                        scaleX: 1,
                        child: Transform.rotate(
                          angle: -260 / 360,
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
                      bottom: h * 0.51,
                      right: w * 0.15,
                      child: SizedBox(
                        width: w * 0.7,
                        height: w * 0.55,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Positioned(
                            //   width: w,
                            //   bottom: w * 0.58,
                            //   right: w * 0.01,
                            //   child: Image.asset(
                            //     "assets/images/cloud.png",
                            //     height: h * 0.11,
                            //   ),
                            // ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: SizedBox(
                                width: w * 0.7,
                                height: w * 0.55,
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
                                  cardBuilder: (context, index,
                                      percentThresholdX, percentThresholdY) {
                                    return cards[index];
                                  },
                                  onSwipe: (previousIndex, currentIndex,
                                      direction) async {
                                    if (currentIndex != 0) {
                                      ref
                                          .read(localeProvider.notifier)
                                          .updateLocale(
                                              languageMap[currentIndex]!);
                                    }

                                    if (currentIndex == cards.length - 1) {
                                      final SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      // what is the difference beetwen Bool and bool
                                      pref.setBool("catPopup", false);
                                    }
                                    setState(() {});
                                    return true;
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: w * 0.3,
                              left: w * 0.52,
                              child: IgnorePointer(
                                child: Image.asset(
                                  "assets/images/wow.png",
                                  height: w * 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Positioned(
                    //   width: w,
                    //   bottom: h * 0.42,
                    //   right: w * 0.22,
                    //   child: IgnorePointer(
                    //     child: Image.asset(
                    //       "assets/images/cloud.png",
                    //       height: h * 0.11,
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      width: w,
                      bottom: h * 0.005,
                      right: w * 0.42,
                      child: Image.asset(
                        "assets/images/fish_dead.png",
                        height: h * 0.08,
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
                      AnimatedBuilder(
                          animation: _heightPosition,
                          builder: (context, child) {
                            return Positioned(
                              width: w,
                              bottom: _heightPosition.value,
                              left: w * 0.22,
                              child: Image.asset(
                                "assets/images/cat_shy.png",
                                height: h * 0.11,
                              ),
                            );
                          }),
                    if (oldSesion)
                      Positioned(
                        top: h * 0.50,
                        bottom: 0,
                        width: w,
                        child: Center(
                          child: OverlayPortal(
                            controller: overlayPortalControllerLangChange,
                            overlayChildBuilder: (context) => AnimatedBuilder(
                              animation: _catAnimationControllerLangChange,
                              builder: (context, child) => LCatPopUp(
                                text: AppLocalizations.of(context)!.emptySets,
                                h: h,
                                w: w,
                                controller: _catAnimationControllerLangChange,
                              ),
                            ),
                            child: SizedBox(
                              width: w * 0.7,
                              height: h * 0.063,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // fetches the data from SP to Game Provider
                                  await ref
                                      .read(gameProvider.notifier)
                                      .readFormPrefs();

                                  // makes a list of words for the current game
                                  Locale curLocale = ref.read(localeProvider);
                                  final localizedSetList = setLocalizationModel
                                      .localizedSetList[curLocale]!;
                                  final usedSetsTitles =
                                      ref.read(gameProvider).setsNames;
                                  final usedSets = localizedSetList
                                      .where(
                                          (s) => usedSetsTitles.contains(s.id))
                                      .toList();
                                  if (usedSets.isEmpty) {
                                    overlayPortalControllerLangChange.show();
                                    _controllerCatLangChange.forward();
                                    Future.delayed(
                                        const Duration(milliseconds: 3000), () {
                                      overlayPortalControllerLangChange.hide();
                                    });

                                    return;
                                  }
                                  ref
                                      .read(gameProvider.notifier)
                                      .makeGameWordSet(usedSets);

                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamed(context, '/score');
                                },
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .continueButton,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
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
                          width: w * 0.7,
                          height: h * 0.063,
                          child: ElevatedButton(
                            onPressed: () async {
                              ref.read(gameProvider.notifier).reset();
                              Navigator.pushNamed(context, '/set_choosing');
                              Future.delayed(
                                const Duration(milliseconds: 200),
                                () => controller.moveTo(0),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.newGameButton,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    wordSpacing: -2,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: h * 0.78,
                      bottom: 0,
                      width: w,
                      child: Center(
                        child: SizedBox(
                          width: w * 0.7,
                          height: h * 0.063,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, '/rules');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 248, 237, 255),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.rulesButton,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: w,
                      bottom: h * 0.08,
                      left: w * 0.34,
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
      ),
    );
  }
}
