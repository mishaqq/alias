import 'package:alias/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';

class ChoosingPage extends ConsumerStatefulWidget {
  const ChoosingPage({super.key});

  @override
  ConsumerState<ChoosingPage> createState() => _GuessingPageState();
}

class _GuessingPageState extends ConsumerState<ChoosingPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  final MultiSelectController<String> _controller = MultiSelectController();
  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.015),
                      child: Text(
                        'Слова',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: h * 0.015,
                          right: h * 0.015,
                          top: h * 0.02,
                        ),
                        child: MultiSelectCheckList(
                          itemPadding: EdgeInsets.all(h * 0.01),
                          maxSelectableCount: 5,
                          textStyles: MultiSelectTextStyles(
                            selectedTextStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: "Anonymous",
                                fontSize: h * 0.020),
                          ),
                          itemsDecoration: MultiSelectDecorations(
                            selectedDecoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 221, 149),
                              border: Border.all(width: h * 0.0015),
                            ),
                          ),
                          listViewSettings: const ListViewSettings(
                            physics: BouncingScrollPhysics(),
                          ),
                          controller: _controller,
                          items: List.generate(
                            SETS.length,
                            (index) => CheckListCard(
                              contentPadding: const EdgeInsets.all(0),
                              decorations: MultiSelectItemDecorations(
                                decoration: BoxDecoration(
                                  border: Border.all(width: h * 0.0015),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(h * 0.018),
                                  ),
                                ),
                              ),
                              textStyles: MultiSelectItemTextStyles(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontFamily: "Anonymous",
                                  fontSize: h * 0.020,
                                ),
                              ),
                              value: SETS[index],
                              title: Text(title[SETS[index]]!),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: h * 0.0020),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.0015),
                                      child: Text(
                                        "${setsTable[SETS[index]]!.length} Слів",
                                        style: TextStyle(fontSize: h * 0.015),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.0015),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            "${example[SETS[index]]}",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: h * 0.015),
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
                                borderRadius: BorderRadius.circular(h * 0.005),
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
                        width: w * 0.65,
                        height: h * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_controller.getSelectedItems().isNotEmpty) {
                              ref.read(gameProvider.notifier).makeGameWordSet(
                                  _controller.getSelectedItems());

                              Navigator.pushNamed(context, "/settings");
                            } else {
                              //TO DO
                            }
                          },
                          child: Text("Продовжити",
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
    );
  }
}
