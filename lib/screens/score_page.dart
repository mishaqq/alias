import 'package:alias/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/dialog.dart';
import '../main.dart';
import '../providers/game_model_provider.dart';

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
                    border: Border.all(width: h * 0.0024),
                    borderRadius: BorderRadius.all(
                      Radius.circular(h * 0.018),
                    ),
                  ),
                  width: w * 0.85,
                  height: h * 0.75,
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
                                    size: w * 0.06,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "/${game.wordsToWin}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: w * 0.047,
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
                                              maxRadius: w * 0.05,
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 221, 149),
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
                                                    fontSize: w * 0.047,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            game.scores[index].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: w * 0.047,
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
                          child: Text(
                            "Зараз: ${game.teams[game.turn]}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: w * 0.047,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                        width: w * 0.18,
                        height: h * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 221, 149),
                          ),
                          onPressed: () {
                            return showAlertDialog(context, ref);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: w * 0.07,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: w * 0.02,
                        ),
                        child: SizedBox(
                          width: w * 0.65,
                          height: h * 0.06,
                          child: ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .read(gameProvider.notifier)
                                  .writeToPrefs();

                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/guessing');
                            },
                            child: Text("Наступний раунд",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyMedium),
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
