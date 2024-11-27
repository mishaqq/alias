// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alias/screens/settings_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/game_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                                top: w * 0.03, bottom: w * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Icons.info_outline,
                                    size: 26.sp,
                                  ),
                                ),
                                Text(
                                  "+${game.wordsToWin}",
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
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                          height: 0,
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: w * 0.00),
                            physics: BouncingScrollPhysics(),
                            itemCount: widget.raundWorlds.length,
                            itemBuilder: (context, index) {
                              if (index == widget.raundWorlds.length - 1 &&
                                  game.lastWord) {
                                /// Column 1

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: w * 0.01),
                                      child: const Divider(
                                        thickness: 2,
                                        color: Colors.black,
                                        height: 0,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashColor: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(w * 0.035),
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
                                          padding: EdgeInsets.only(
                                              top: h * 0.014, bottom: h * 0.03),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: w * 0.65,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: w * 0.01),
                                                  child: Text(
                                                    widget.raundWorlds.keys
                                                        .toList()[index],
                                                    maxLines: 4,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 20.sp,
                                                            height: 1.2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                  ),
                                                ),
                                              ),
                                              widget.raundWorlds.values
                                                          .toList()[index] ==
                                                      1
                                                  ? Image.asset(
                                                      "assets/images/plus.png",
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: w * 0.07,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/minus.png",
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: w * 0.07,
                                                    )
                                            ],
                                            //Text(
                                            //raundWorlds.values.toList()[index].toString(),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                // Last Element
                                return Column(
                                  children: [
                                    index != 0
                                        ? const DottedLine(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.center,
                                            lineThickness: 2.0,
                                            dashLength: 8.0,
                                            dashColor: Colors.black,
                                            dashGapLength: 10,
                                            dashGapColor: Colors.transparent,
                                          )
                                        : const SizedBox(),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
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
                                        splashColor: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(w * 0.035),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: h * 0.014,
                                              bottom: h * 0.014),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: w * 0.65,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: w * 0.01),
                                                  child: Text(
                                                    widget.raundWorlds.keys
                                                        .toList()[index],
                                                    maxLines: 4,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 20.sp,
                                                            height: 1.2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                  ),
                                                ),
                                              ),
                                              widget.raundWorlds.values
                                                          .toList()[index] ==
                                                      1
                                                  ? Image.asset(
                                                      "assets/images/plus.png",
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: w * 0.07,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/minus.png",
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: w * 0.07,
                                                    )
                                            ],
                                            //Text(
                                            //raundWorlds.values.toList()[index].toString(),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                        width: w * 0.15,
                        height: w * 0.15,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Color.fromARGB(255, 248, 237, 255),
                            padding: EdgeInsets.zero,
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
                          width: w * 0.68,
                          height: w * 0.15,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor:
                                  Color.fromARGB(255, 255, 221, 149),
                            ),
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
                            child: Text(AppLocalizations.of(context)!.next,
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
        side: BorderSide(width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(w * 0.035),
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
                                  MediaQuery.of(context).size.width * 0.035),
                            ),
                          ),
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(
                              index == teams.length ? "Nobody" : teams[index]);
                        },
                        child: Text(
                          index == teams.length
                              ? AppLocalizations.of(context)!.nobody
                              : teams[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ),
                    ),
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
