import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../forks/item_count.dart';
import '../providers/game_model_provider.dart';
import '../providers/selection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final bool fromGame;
  const SettingsPage({required this.fromGame, super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingPageState();
}

int wordsQuantity = 20;

class _SettingPageState extends ConsumerState<SettingsPage> {
  final Map<int, int> durationTable = {
    0: 10,
    1: 30,
    2: 60,
    3: 90,
    4: 120,
  };

  @override
  Widget build(BuildContext context) {
    final isSelected = ref.watch(isSelectedProvider);
    final wordsQuantity = ref.watch(counterProvider);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
                ),
                width: w * 0.85,
                height: h * 0.72,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: h * 0.01,
                    right: h * 0.015,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.015),
                        child: Text(
                          AppLocalizations.of(context)!.settingsTitle,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 24.sp,
                                  ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h * 0.03,
                          ),
                          Text(
                            AppLocalizations.of(context)!.durationTitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 18.sp,
                                ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.02),
                                child: ToggleButtons(
                                  borderWidth: h * 0.002,
                                  splashColor: Colors.transparent,
                                  borderColor: Colors.black,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 221, 149),
                                  selectedBorderColor: Colors.black,
                                  constraints: BoxConstraints(
                                      maxWidth: w * 0.5, maxHeight: h * 0.1),
                                  // borderColor: Colors.black,

                                  isSelected: isSelected,
                                  onPressed: (newIndex) {
                                    ref
                                        .read(isSelectedProvider.notifier)
                                        .updateSelection(newIndex, true);
                                  },
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: w * 0.03,
                                          right: w * 0.03,
                                          top: h * 0.01,
                                          bottom: h * 0.01),
                                      child: Text(
                                        "10",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: w * 0.047,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: w * 0.03,
                                          right: w * 0.03,
                                          top: h * 0.01,
                                          bottom: h * 0.01),
                                      child: Text(
                                        "30",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: w * 0.047,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: w * 0.03,
                                          right: w * 0.03,
                                          top: h * 0.01,
                                          bottom: h * 0.01),
                                      child: Text(
                                        "60",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: w * 0.047,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: w * 0.03,
                                          right: w * 0.03,
                                          top: h * 0.01,
                                          bottom: h * 0.01),
                                      child: Text(
                                        "90",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: w * 0.047,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: w * 0.03,
                                          right: w * 0.03,
                                          top: h * 0.01,
                                          bottom: h * 0.01),
                                      child: Text(
                                        "120",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: w * 0.047,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: h * 0.035,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.wordsToWinTitle,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 18.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                                ItemCount(
                                  color: Color.fromARGB(255, 255, 221, 149),
                                  buttonSizeHeight: 30.sp,
                                  buttonSizeWidth: 30.sp,
                                  initialValue: wordsQuantity,
                                  minValue: 5,
                                  step: 5,
                                  maxValue: 200,
                                  decimalPlaces: 0,
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: w * 0.047,
                                      ),
                                  onChanged: (value) {
                                    setState(() {
                                      ref
                                          .read(counterProvider.notifier)
                                          .setValue(value.toInt());
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: h * 0.035,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.lastWordTitle,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 18.sp,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: h * 0.004, right: w * 0.015),
                                  child: SizedBox(
                                    width: 20.sp,
                                    height: 20.sp,
                                    child: Transform.scale(
                                      scale: 1.1.sp,
                                      child: Checkbox(
                                        value: ref.read(gameProvider).lastWord,
                                        onChanged: (value) {
                                          setState(() {
                                            ref
                                                .read(gameProvider.notifier)
                                                .toggleLastWord();
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(h * 0.005),
                                        ),
                                        side: const BorderSide(
                                            color: Colors.black),
                                        fillColor: const WidgetStatePropertyAll(
                                            Color.fromARGB(255, 255, 221, 149)),
                                        overlayColor:
                                            const WidgetStatePropertyAll(
                                          Colors.transparent,
                                        ),
                                        checkColor: Colors.black,
                                        activeColor: const Color.fromARGB(
                                            255, 255, 221, 149),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                          onPressed: () {
                            int durationIndex = isSelected.indexOf(true);

                            ref
                                .read(gameProvider.notifier)
                                .setDuration(durationTable[durationIndex]!);

                            ref
                                .read(gameProvider.notifier)
                                .setWordsToWin(context, wordsQuantity);
                            widget.fromGame
                                ? Navigator.pop(context)
                                : Navigator.pushNamed(context, '/team');
                          },
                          child: widget.fromGame
                              ? Text(AppLocalizations.of(context)!.acceptButton,
                                  style: Theme.of(context).textTheme.bodyMedium)
                              : Text(
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
