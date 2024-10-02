// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';

// ignore: must_be_immutable
class CountPage extends ConsumerStatefulWidget {
  Map<String, int> raundWorlds;
  String nameOfLastTeam;

  CountPage({
    super.key,
    required this.raundWorlds,
    required this.nameOfLastTeam,
  });

  @override
  ConsumerState<CountPage> createState() => _CountPageState();
}

class _CountPageState extends ConsumerState<CountPage> {
  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false; // TO DO
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
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: h * 0.01),
                            physics: BouncingScrollPhysics(),
                            itemCount: widget.raundWorlds.length,
                            itemBuilder: (context, index) {
                              if (index == widget.raundWorlds.length - 1 &&
                                  game.lastWord) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.01),
                                      child: Divider(
                                        indent: w * 0.01,
                                        endIndent: w * 0.01,
                                        thickness: h * 0.002,
                                        height: w * 0.03,
                                        color: Colors.black,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        widget.nameOfLastTeam =
                                            (await openDialog())!;

                                        setState(() {
                                          String key = widget.raundWorlds.keys
                                              .toList()[index];
                                          if (widget.nameOfLastTeam ==
                                              "Nobody") {
                                            widget.raundWorlds[key] = 0;
                                          } else {
                                            widget.raundWorlds[key] = 1;
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(top: h * 0.01),
                                        child: ListTile(
                                            dense: true,
                                            minVerticalPadding: 0,
                                            visualDensity: VisualDensity(
                                                horizontal: 0, vertical: -4),
                                            title: Text(
                                              widget.raundWorlds.keys
                                                  .toList()[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: w * 0.047,
                                                  ),
                                            ),
                                            trailing: widget.raundWorlds.values
                                                        .toList()[index] ==
                                                    1
                                                ? Icon(
                                                    Icons.check_circle_outline,
                                                    color: Colors.green,
                                                    size: 20.sp,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_unchecked_outlined,
                                                    color: Colors.red,
                                                    size: 20.sp,
                                                  )),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      String key = widget.raundWorlds.keys
                                          .toList()[index];
                                      if (widget.raundWorlds[key] == 1) {
                                        widget.raundWorlds[key] = 0;
                                      } else {
                                        widget.raundWorlds[key] = 1;
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: h * 0.01),
                                    child: ListTile(
                                        dense: true,
                                        minVerticalPadding: 0,
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        title: Text(
                                          widget.raundWorlds.keys
                                              .toList()[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: w * 0.047,
                                              ),
                                        ),
                                        trailing: widget.raundWorlds.values
                                                    .toList()[index] ==
                                                1
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.green,
                                                size: 20.sp,
                                              )
                                            : Icon(
                                                Icons
                                                    .radio_button_unchecked_outlined,
                                                color: Colors.red,
                                                size: 20.sp,
                                              )
                                        //Text(
                                        //raundWorlds.values.toList()[index].toString(),
                                        // ),
                                        ),
                                  ),
                                );
                              }
                            },
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
                        height: h * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 255, 221, 149),
                          ),
                          onPressed: () {
                            // return showAlertDialog(context, ref); // TO DO
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
                          width: w * 0.65,
                          height: h * 0.07,
                          child: ElevatedButton(
                            onPressed: () async {
                              //       calculating the score
                              int roundScore = 0;
                              //print(widget.raundWorlds);
                              for (int i = 0;
                                  i <
                                      (game.lastWord
                                          ? widget.raundWorlds.values
                                                  .toList()
                                                  .length -
                                              1
                                          : widget.raundWorlds.values
                                              .toList()
                                              .length);
                                  i++) {
                                // ignore: unrelated_type_equality_checks
                                if (widget.raundWorlds.values.toList()[i] ==
                                    0) {
                                  roundScore--;
                                } else {
                                  roundScore++;
                                }
                              }

                              // for (int value in widget.raundWorlds.values) {
                              //   if (value == 0) {
                              //     roundScore--;
                              //   } else {
                              //     roundScore++;
                              //   }
                              // }

                              // team is getting the points
                              if (roundScore > 0) {
                                ref.read(gameProvider.notifier).updateScore(
                                    ref.read(gameProvider).turn, roundScore);
                              }

                              //last team gets the point
                              if (widget.nameOfLastTeam != "Nobody" &&
                                  game.lastWord) {
                                ref.read(gameProvider.notifier).updateScore(
                                    game.teams.indexOf(widget.nameOfLastTeam),
                                    1);
                              }

                              //next turn
                              ref.read(gameProvider.notifier).nextTurn();

                              //checks winner if all other teams played
                              if (ref.read(gameProvider).turn == 0) {
                                ref
                                    .read(gameProvider.notifier)
                                    .winCheck(context);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Далі",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 19.sp,
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

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => CustomDialogScore(
          teams: ref.read(gameProvider).teams,
        ),
      );
}

class CustomDialogScore extends StatelessWidget {
  final List<String> teams;

  const CustomDialogScore({
    super.key,
    required this.teams,
  });

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
      child: Padding(
        padding: EdgeInsets.only(top: h * 0.006),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: (h * 0.058) * teams.length <
                      MediaQuery.of(context).size.height
                  ? ((h * 0.058) * (teams.length + 1)).toDouble()
                  : MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.002),
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
                                width: MediaQuery.of(context).size.height *
                                    0.0024),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  MediaQuery.of(context).size.height * 0.00),
                            ),
                          ),
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(
                              index == teams.length ? "Nobody" : teams[index]);
                        },
                        child: Text(
                          index == teams.length ? "Ніхто" : teams[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 10.sp,
                                  ),
                        ),
                      ),
                    ),

                    //SizedBox(
                    //   width: w * 0.85,
                    //   height: h * 0.05,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.of(context).pop(
                    //           index == teams.length ? "Nobody" : teams[index]);
                    //     },
                    //     child: Text(
                    //       index == teams.length ? "Nobody" : teams[index],
                    //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    //             fontSize: w * 0.047,
                    //           ),
                    //       maxLines: 1,
                    //       overflow: TextOverflow.ellipsis,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
