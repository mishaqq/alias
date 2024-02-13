import 'package:alias/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../forks/item_count.dart';
import '../providers/game_model_provider.dart';
import '../providers/selection.dart';

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
                        padding: EdgeInsets.only(top: h * 0.015),
                        child: Text(
                          'Налаштування',
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: h * 0.05,
                          ),
                          Text(
                            "Тривалість раунду:",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: w * 0.047,
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
                                  fillColor: Color.fromARGB(255, 255, 221, 149),
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
                              top: h * 0.020,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Слів до перемоги:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: w * 0.047,
                                      ),
                                ),
                                ItemCount(
                                  color: Color.fromARGB(255, 255, 221, 149),
                                  buttonSizeHeight: w * 0.1,
                                  buttonSizeWidth: w * 0.1,
                                  initialValue: wordsQuantity,
                                  minValue: 10,
                                  step: 10,
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
                              top: h * 0.025,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Останнє слово для всіх:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: w * 0.047,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: h * 0.004, right: w * 0.02),
                                  child: SizedBox(
                                    width: w * 0.06,
                                    height: w * 0.06,
                                    child: Transform.scale(
                                      scale: w * 0.004,
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
                                        side: BorderSide(color: Colors.black),
                                        fillColor: MaterialStatePropertyAll(
                                            Color.fromARGB(255, 255, 221, 149)),
                                        overlayColor: MaterialStatePropertyAll(
                                          Colors.transparent,
                                        ),
                                        checkColor: Colors.black,
                                        activeColor:
                                            Color.fromARGB(255, 255, 221, 149),
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
                      width: w * 0.18,
                      height: h * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 221, 149),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
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
                              ? Text("Перейняти",
                                  style: Theme.of(context).textTheme.bodyMedium)
                              : Text("Продовжити",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
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
