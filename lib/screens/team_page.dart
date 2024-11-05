import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// TODO : Add animation for teama appearence
class TeamPage extends ConsumerWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
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
                          top: h * 0.01,
                          bottom: w * 0.03,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.teamsTitle,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 24.sp,
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
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemCount: (game.teams.length + 1),
                          itemBuilder: (context, index) => index !=
                                  (game.teams.length)
                              ? Padding(
                                  padding: EdgeInsets.only(top: h * 0.009),
                                  child: GestureDetector(
                                    onTap: () => print("TO DO"),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: w * 0.03),
                                            child: CircleAvatar(
                                              child: ClipOval(
                                                child: Image.asset(
                                                    game.avatars[index]),
                                              ),
                                              maxRadius: w * 0.05,
                                              backgroundColor:
                                                  Colors.transparent,
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
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: w * 0.015),
                                            child: SizedBox(
                                              width: 30.sp,
                                              height: 30.sp,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.delete_outline_outlined,
                                                  size: 22.sp,
                                                ),
                                                onPressed: () {
                                                  if (game.teams.length > 2) {
                                                    ref
                                                        .read(gameProvider
                                                            .notifier)
                                                        .deleteTeam(index);
                                                  }
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: w * 0.03),
                                      child: Divider(
                                        indent: w * 0.01,
                                        endIndent: w * 0.01,
                                        thickness: h * 0.002,
                                        height: w * 0.03,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.001),
                                      child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(gameProvider.notifier)
                                              .addTeam();
                                        },
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: w * 0.03),
                                                child: CircleAvatar(
                                                  maxRadius: w * 0.05,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 221, 149),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                    size: w * 0.04,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .addTeamButton,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 18.sp,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                      width: w * 0.15,
                      height: w * 0.15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 248, 237, 255),

                          padding: EdgeInsets.zero, // Remove any padding
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
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
                            backgroundColor: Color.fromARGB(255, 255, 221, 149),
                          ),
                          onPressed: () async {
                            await ref
                                .read(gameProvider.notifier)
                                .writeToPrefs();

                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, '/score');
                          },
                          child: Text(
                              AppLocalizations.of(context)!.continueButton,
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
    );
  }
}
// TODO add popup "you cant add more teams"
// Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 2,
//             child: ListView.builder(
//               physics: const BouncingScrollPhysics(),
//               itemCount: game.teams.length,
//               itemBuilder: (context, index) => ListTile(
//                   title: Text(
//                     game.teams[index],
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       if (game.teams.length > 2) {
//                         ref.read(gameProvider.notifier).deleteTeam(index);
//                       }
//                     },
//                   )),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               ref.read(gameProvider.notifier).addTeam();
//             },
//             child: const Text("Add Team"),
//           ),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     ref.read(gameProvider.notifier).reset(context);
//           //   },
//           //   child: Text("Reset"),
//           // ),
//           ElevatedButton(
//             onPressed: () async {
//               // TO DO
//               // Add popup -- Old session will be deleated

//               /// rewrites old session in SP
//               await ref.read(gameProvider.notifier).writeToPrefs();

//               // ignore: use_build_context_synchronously
//               Navigator.pushNamed(context, '/score');
//             },
//             child: const Text("Start the game"),
//           ),
//         ],
//       ),
//     );