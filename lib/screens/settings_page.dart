import 'package:alias/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../forks/item_count.dart';
import '../providers/game_model_provider.dart';
import '../providers/selection.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Settings"),
            ToggleButtons(
              borderWidth: 3,
              // borderColor: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("10"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("30"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("60"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("90"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("120"),
                ),
              ],
              isSelected: isSelected,
              onPressed: (newIndex) {
                ref
                    .read(isSelectedProvider.notifier)
                    .updateSelection(newIndex, true);
              },
            ),
            ItemCount(
              buttonSizeHeight: 50,
              buttonSizeWidth: 50,
              initialValue: wordsQuantity,
              minValue: 10,
              step: 10,
              maxValue: double.infinity,
              decimalPlaces: 0,
              onChanged: (value) {
                setState(() {
                  ref.read(counterProvider.notifier).setValue(value.toInt());
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                int durationIndex = isSelected.indexOf(true);

                ref
                    .read(gameProvider.notifier)
                    .setDuration(durationTable[durationIndex]!);

                ref.read(gameProvider.notifier).setWordsToWin(wordsQuantity);

                Navigator.pushNamed(context, '/team');
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
