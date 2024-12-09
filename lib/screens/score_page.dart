import 'package:alias/screens/rules.dart';
import 'package:alias/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/dialog.dart';
import '../providers/game_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScorePage extends ConsumerWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return showAlertDialog(context, ref);
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
              top: h * 0.09,
              left: w * 0.075,
              right: w * 0.075,
            ),
            child: Column(
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
                        offset: Offset(0.0, 5.0), //(x,y)
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  width: w * 0.85,
                  height: h * 0.72,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: h * 0.015,
                      right: h * 0.015,
                    ),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: h * 0.015, bottom: w * 0.03),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingsPage(
                                          fromGame: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.settings_outlined,
                                    size: 26.sp,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "/${game.wordsToWin}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 20.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                )
                              ],
                            )),
                        Divider(
                          height: 0,
                          thickness: h * 0.0024,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              itemCount: game.teams.length,
                              itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(top: h * 0.009),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: w * 0.03),
                                            child: CircleAvatar(
                                              radius: w * 0.058,
                                              backgroundColor: Colors.black,
                                              child: CircleAvatar(
                                                maxRadius:
                                                    game.teams[game.turn] ==
                                                            game.teams[index]
                                                        ? w * 0.053
                                                        : w * 0.058,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: ClipOval(
                                                  child: Image.asset(
                                                      game.avatars[index]),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              game.teams[index],
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
                                          Text(
                                            game.scores[index].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 20.sp,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                        Divider(
                          height: 0,
                          thickness: h * 0.0024,
                          color: Colors.black,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: w * 0.03, bottom: w * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RulesPage(
                                        selected: 3,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.info_outline,
                                  size: 22.sp,
                                ),
                              ),
                              SizedBox(
                                width: w * 0.01,
                              ),
                              SizedBox(
                                width: w * 0.7,
                                child: Center(
                                  child: Text(
                                    "${AppLocalizations.of(context)!.currentTurn} ${game.teams[game.turn]}",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 18.sp,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                Padding(
                  padding: EdgeInsets.only(
                    top: h * 0.01,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: w * 0.15,
                        height: w * 0.15,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor:
                                const Color.fromARGB(255, 248, 237, 255),
                            padding: EdgeInsets.zero, // Remove any padding
                          ),
                          onPressed: () {
                            return showAlertDialog(context, ref);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: w * 0.02,
                        ),
                        child: SizedBox(
                          width: w * 0.68,
                          height: w * 0.15,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor:
                                  Color.fromARGB(255, 255, 221, 149),
                            ),
                            onPressed: () async {
                              await ref
                                  .read(gameProvider.notifier)
                                  .writeToPrefs();

                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/guessing');
                            },
                            child: Text(
                                AppLocalizations.of(context)!.nextRoundButton,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 20.sp,
                                    )),
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
      ),
    );
  }
}






// class ScorePage extends ConsumerWidget {
//   const ScorePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final game = ref.watch(gameProvider);

//     return WillPopScope(
//       onWillPop: () async {
//         return showAlertDialog(context, ref);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//         ),
//         body: Column(
//           children: [
//             Text(
//               "Next turn: ${game.teams[game.turn]}",
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height / 2,
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: game.teams.length,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(
//                     game.teams[index],
//                   ),
//                   trailing: Text(
//                     game.scores[index].toString(),
//                   ),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/guessing');
//               },
//               child: Text("Start next round"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
