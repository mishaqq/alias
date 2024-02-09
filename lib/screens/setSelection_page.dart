import 'package:alias/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../providers/game_model_provider.dart';
import '../providers/setsProvider.dart';

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
            top: MediaQuery.of(context).size.height * 0.09,
            left: MediaQuery.of(context).size.width * 0.075,
            right: MediaQuery.of(context).size.width * 0.075,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 248, 237, 255),
                  border: Border.all(
                      width: MediaQuery.of(context).size.height * 0.0024),
                  borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.height * 0.018),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.015),
                      child: Text(
                        'Слова',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.015,
                          right: MediaQuery.of(context).size.height * 0.015,
                        ),
                        child: MultiSelectCheckList(
                          itemPadding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01),
                          maxSelectableCount: 5,
                          textStyles: MultiSelectTextStyles(
                            selectedTextStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: "Anonymous",
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.020),
                          ),
                          itemsDecoration: MultiSelectDecorations(
                            selectedDecoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 221, 149),
                              border: Border.all(
                                  width: MediaQuery.of(context).size.height *
                                      0.0015),
                            ),
                          ),
                          listViewSettings: ListViewSettings(
                            physics: const BouncingScrollPhysics(),
                          ),
                          controller: _controller,
                          items: List.generate(
                            SETS.length,
                            (index) => CheckListCard(
                              contentPadding: EdgeInsets.all(0),
                              decorations: MultiSelectItemDecorations(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.0015),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.018),
                                  ),
                                ),
                              ),
                              textStyles: MultiSelectItemTextStyles(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontFamily: "Anonymous",
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.020,
                                ),
                              ),
                              value: SETS[index],
                              title: Text(title[SETS[index]]!),
                              subtitle: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.0020),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0015),
                                      child: Text(
                                        "${setsTable[SETS[index]]!.length} Слів",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0015),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "${example[SETS[index]]}",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.015),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              selectedColor: Colors.white,
                              checkColor: Colors.black,
                              leadingCheckBox: false,
                              checkBoxBorderSide:
                                  const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.005),
                              ),
                            ),
                          ),
                          onChange: (allSelectedItems, selectedItem) {},
                          onMaximumSelected:
                              (allSelectedItems, selectedItem) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                      height: MediaQuery.of(context).size.height * 0.06,
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
                          size: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(gameProvider.notifier).makeGameWordSet(
                                _controller.getSelectedItems());

                            Navigator.pushNamed(context, "/settings");
                          },
                          child: Text("Продовжити",
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
    );
  }
}
