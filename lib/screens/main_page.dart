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
                    width: MediaQuery.of(context).size.width,
                    bottom: MediaQuery.of(context).size.height * 0.42,
                    right: MediaQuery.of(context).size.width * 0.22,
                    child: Image.asset(
                      "assets/images/cloud.png",
                      height: MediaQuery.of(context).size.height * 0.11,
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: MediaQuery.of(context).size.height * 0.55,
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset(
                      "assets/images/cloud.png",
                      height: MediaQuery.of(context).size.height * 0.11,
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: MediaQuery.of(context).size.height * 0.75,
                    child: Image.asset(
                      "assets/images/cloud.png",
                      height: MediaQuery.of(context).size.height * 0.11,
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    top: MediaQuery.of(context).size.height * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 1,
                      ),
                    ),
                  ),
                  if (oldSesion)
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.50,
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.055,
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
                    top: MediaQuery.of(context).size.height * 0.63,
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: ElevatedButton(
                            onPressed: () async {
                              ref.read(gameProvider.notifier).reset();
                              Navigator.pushNamed(context, '/set_choosing');
                            },
                            child: Text("Почати гру",
                                style: Theme.of(context).textTheme.bodyMedium)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.76,
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.055,
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

//Image.asset(
//   "assets/images/logo.png",
//   width: MediaQuery.of(context).size.width,
// ),

// if (oldSesion)
//               ElevatedButton(
//                 onPressed: () async {
//                   // fetches the data from SP to Game Provider
//                   await ref.read(gameProvider.notifier).readFormPrefs();

//                   // makes a list of words for the current game
//                   ref
//                       .read(gameProvider.notifier)
//                       .makeGameWordSet(ref.read(gameProvider).setsNames);

//                   // ignore: use_build_context_synchronously
//                   Navigator.pushNamed(context, '/score');
//                 },
//                 child: const Text("Continue"),
//               )
//             else
//               const SizedBox(),
//             ElevatedButton(
//               onPressed: () async {
//                 ref.read(gameProvider.notifier).reset();
//                 Navigator.pushNamed(context, '/set_choosing');
//               },
//               child: const Text("Start Game!"),
//             ),
//  Positioned(
//                           bottom: MediaQuery.of(context).size.height * 0.46,
//                           left: MediaQuery.of(context).size.width * 0.31,
//                           child: Image.asset(
//                             "assets/images/cloud.png",
//                             height: MediaQuery.of(context).size.height * 0.12,
//                           ),
//                         ),
//                         Positioned(
//                           top: 0,
//                           bottom: 100,
//                           child: Image.asset(
//                             "assets/images/logo.png",
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                         ),



//  return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color.fromARGB(255, 25, 178, 238),
//               Color.fromARGB(255, 21, 236, 229)
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Expanded(
//               flex: 5,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Positioned(
//                           bottom: 240.h,
//                           left: 100.w,
//                           child: Image.asset(
//                             "assets/images/cloud.png",
//                             height: 100.r,
//                           ),
//                         ),
//                         Positioned(
//                           top: 0,
//                           bottom: 100,
//                           child: Image.asset(
//                             "assets/images/logo.png",
//                             width: MediaQuery.of(context).size.width,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Column(
//                 children: [],
//               ),
//             )
//           ],
//         ),
//       ),
//     );



// return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color.fromARGB(255, 25, 178, 238),
//               Color.fromARGB(255, 21, 236, 229)
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             SizedBox(
//               height: 500.r,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Positioned(
//                     bottom: 240.h,
//                     left: 100.w,
//                     child: Image.asset(
//                       "assets/images/cloud.png",
//                       height: 100.r,
//                     ),
//                   ),
//                   Positioned(
//                     top: 0.h,
//                     bottom: 100.h,
//                     child: Image.asset(
//                       "assets/images/logo.png",
//                       width: 400.w,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: (MediaQuery.of(context).size.height /
//                       MediaQuery.of(context).size.width) *
//                   0.4,
//               child: Column(
//                 children: [],
//               ),
//             )
//           ],
//         ),
//       ),
//     );