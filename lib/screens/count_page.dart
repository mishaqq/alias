// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:alias/elements/cat_popup.dart';
import 'package:alias/models/game_model.dart';
import 'package:alias/screens/guessing_page.dart';
import 'package:alias/screens/rules.dart';
import 'package:alias/screens/settings_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/game_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum GameMod { normal, lastWord, noMinusPoints }

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

class _CountPageState extends ConsumerState<CountPage>
    with TickerProviderStateMixin {
  int roundScore = 0;
  late AnimationController _controllerCat;
  late Animation<double> _catAnimationController;
  late OverlayPortalController overlayPortalController;

  @override
  initState() {
    super.initState();

    overlayPortalController = OverlayPortalController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
    });
  }

  void _setRoundScore({GameMod? lastWord, GameMod? points}) {
    log("rebuild");
    roundScore = 0;
    for (int i = 0;
        i <
            (lastWord == GameMod.lastWord
                ? widget.raundWorlds.values.toList().length - 1
                : widget.raundWorlds.values.toList().length);
        i++) {
      // ignore: unrelated_type_equality_checks
      if (widget.raundWorlds.values.toList()[i] == 0 &&
          points != GameMod.noMinusPoints) {
        roundScore--;
      } else {
        roundScore += widget.raundWorlds.values.toList()[i];
      }
    }
    setState(() {
      roundScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);

    _setRoundScore(
        lastWord: game.lastWord ? GameMod.lastWord : GameMod.normal,
        points: game.isNoMinusPoints ? GameMod.noMinusPoints : GameMod.normal);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false; // TO DO
      },
      child: Scaffold(
        body: OverlayPortal(
          controller: overlayPortalController,
          overlayChildBuilder: (context) => AnimatedBuilder(
            animation: _catAnimationController,
            builder: (context, child) => LCatPopUp(
              text: AppLocalizations.of(context)!.countBackArrow,
              h: h,
              w: w,
              controller: _catAnimationController,
            ),
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
                                children: [
                                  SizedBox(width: w * 0.01),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RulesPage(
                                            selected: 2,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.info_outline,
                                      size: 26.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    roundScore > 0 ? "+$roundScore" : "+0",
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
                                              String key = widget
                                                  .raundWorlds.keys
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
                                                top: h * 0.014,
                                                bottom: h * 0.03),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    ? CircleAvatar(
                                                        maxRadius: w * 0.058,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                            game.avatars[game
                                                                .teams
                                                                .indexOf(widget
                                                                    .nameOfLastTeam)],
                                                          ),
                                                        ),
                                                      )
                                                    : CircleAvatar(
                                                        radius: w * 0.058,
                                                        backgroundColor:
                                                            const Color
                                                                .fromRGBO(194,
                                                                193, 193, 1),
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                            "assets/images/fish_dead.png",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
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
                                              String key = widget
                                                  .raundWorlds.keys
                                                  .toList()[index];
                                              if (widget.raundWorlds[key] ==
                                                  1) {
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                        alignment: Alignment
                                                            .centerRight,
                                                        width: w * 0.07,
                                                      )
                                                    : Image.asset(
                                                        "assets/images/minus.png",
                                                        alignment: Alignment
                                                            .centerRight,
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
                              backgroundColor:
                                  Color.fromARGB(255, 248, 237, 255),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              overlayPortalController.show();
                              _controllerCat.forward();
                              Future.delayed(
                                const Duration(milliseconds: 3000),
                                () => {
                                  _controllerCat.reverse().then((_) {
                                    overlayPortalController.hide();
                                  }),
                                },
                              );
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
                                //int roundScore = _getRoundScore(game);
                                //print(widget.raundWorlds);

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
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => CustomDialog(
          teams: ref.read(gameProvider).teams,
          roundWords: widget.raundWorlds,
          avatars: ref.read(gameProvider).avatars,
          lastWord: AppLocalizations.of(context)!.whoGuessed,
          isFromScore: true,
        ),
      );
}
