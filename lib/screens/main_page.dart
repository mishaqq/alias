import 'package:alias/providers/setsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../providers/game_model_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

bool oldSesion = false;

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    // when the page loads it reads from the SP if there was an old session and saves it to the Game Provider state
    ref.read(gameProvider.notifier).oldGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oldSesion = ref.watch(gameProvider).oldSesion;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
                    bottom: h * 0.42,
                    right: w * 0.22,
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
                    width: w,
                    bottom: h * 0.75,
                    child: Image.asset(
                      "assets/images/cloud.png",
                      height: h * 0.11,
                    ),
                  ),
                  Positioned(
                    width: w,
                    top: h * 0.1,
                    bottom: h * 0.5,
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: h * 0.20,
                        width: w * 1,
                      ),
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
                          height: h * 0.055,
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
                    top: h * 0.63,
                    bottom: 0,
                    width: w,
                    child: Center(
                      child: SizedBox(
                        width: w * 0.8,
                        height: h * 0.055,
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
                    top: h * 0.76,
                    bottom: 0,
                    width: w,
                    child: Center(
                      child: SizedBox(
                        width: w * 0.8,
                        height: h * 0.055,
                        child: ElevatedButton(
                            onPressed: () async {
                              ref.read(gameProvider.notifier).reset();
                              Navigator.pushNamed(context, '/set_choosing');
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
