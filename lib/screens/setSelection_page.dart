import 'package:alias/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../providers/game_model_provider.dart';

class ChoosingPage extends ConsumerStatefulWidget {
  const ChoosingPage({super.key});

  @override
  ConsumerState<ChoosingPage> createState() => _GuessingPageState();
}

class _GuessingPageState extends ConsumerState<ChoosingPage> {
  @override
  void initState() {
    super.initState();
  }

  final MultiSelectController<String> _controller = MultiSelectController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select word sets',
              ),
            ),
            Expanded(
              child: MultiSelectCheckList(
                maxSelectableCount: 5,
                textStyles: const MultiSelectTextStyles(
                    selectedTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                itemsDecoration: MultiSelectDecorations(
                    selectedDecoration:
                        BoxDecoration(color: Colors.indigo.withOpacity(0.8))),
                listViewSettings: ListViewSettings(
                    separatorBuilder: (context, index) => const Divider(
                          height: 0,
                        )),
                controller: _controller,
                items: List.generate(
                    SETS.length,
                    (index) => CheckListCard(
                        value: SETS[index],
                        title: Text(SETS[index]),
                        subtitle:
                            Text("${setsTable[SETS[index]]!.length} Words"),
                        selectedColor: Colors.white,
                        checkColor: Colors.indigo,
                        leadingCheckBox: false,
                        checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                onChange: (allSelectedItems, selectedItem) {},
                onMaximumSelected: (allSelectedItems, selectedItem) {},
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(gameProvider.notifier)
                    .makeGameWordSet(_controller.getSelectedItems());
                print(ref.read(gameProvider).usedWordSets.length);
                Navigator.pushNamed(context, "/settings");
              },
              child: Text("Confirm"),
            ),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences pref =
                    await SharedPreferences.getInstance();
                print(pref.getStringList('gameSets'));
                //await pref.clear();
              },
              child: Text("Check"),
            ),
          ],
        ),
      ),
    );
  }
}
