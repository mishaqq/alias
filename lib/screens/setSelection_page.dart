import 'package:alias/core/constants.dart';
import 'package:alias/models/set_model.dart';
import 'package:alias/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChoosingPage extends ConsumerStatefulWidget {
  const ChoosingPage({super.key});

  @override
  ConsumerState<ChoosingPage> createState() => _GuessingPageState();
}

class _GuessingPageState extends ConsumerState<ChoosingPage> {
  late List<AliasSet> localizedSetList;

  @override
  void initState() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    Locale curLocale = ref.read(localeProvider);
    localizedSetList = setLocalizationModel.localizedSetList[curLocale]!;
    super.initState();
  }

  final MultiSelectController<AliasSet> _controller = MultiSelectController();
  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.01),
                      child: Text(
                        AppLocalizations.of(context)!.words,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 24.sp,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: h * 0.015,
                          right: h * 0.015,
                          top: h * 0.01,
                        ),
                        child: MultiSelectCheckList(
                          chechboxScaleFactor: 0.8,
                          itemPadding: EdgeInsets.all(w * 0.02),
                          maxSelectableCount: 5,
                          textStyles: MultiSelectTextStyles(
                            selectedTextStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: "Anonymous",
                                fontSize: 18.sp),
                          ),
                          itemsDecoration: MultiSelectDecorations(
                            selectedDecoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 221, 149),
                              border: Border.all(width: 2),
                            ),
                          ),
                          listViewSettings: ListViewSettings(
                            padding: EdgeInsets.only(
                                bottom: h * 0.01, top: h * 0.03),
                            physics: const BouncingScrollPhysics(),
                          ),
                          controller: _controller,
                          items: List.generate(
                            localizedSetList.length,
                            (index) => CheckListCard(
                              contentPadding: const EdgeInsets.all(0),
                              decorations: MultiSelectItemDecorations(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(w * 0.035),
                                  ),
                                ),
                              ),
                              textStyles: MultiSelectItemTextStyles(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontFamily: "Anonymous",
                                  fontSize: 18.sp,
                                ),
                              ),
                              value: localizedSetList[index],
                              title: Text(localizedSetList[index].title),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: w * 0.01),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: w * 0.001),
                                      child: Text(
                                        "${localizedSetList[index].contents.length} ${AppLocalizations.of(context)!.wordsAmount}", //TODO : Translate
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: w * 0.001),
                                      child: Wrap(
                                        children: [
                                          Text(
                                            localizedSetList[index].example,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14.sp,
                                              overflow: TextOverflow.ellipsis,
                                            ),
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
                      width: w * 0.15,
                      height: w * 0.15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Color.fromARGB(255, 255, 221, 149),
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
                          onPressed: () {
                            if (_controller.getSelectedItems().isNotEmpty) {
                              ref.read(gameProvider.notifier).makeGameWordSet(
                                  _controller.getSelectedItems());

                              Navigator.pushNamed(context, "/settings");
                            } else {
                              //TO DO add popup no sets selected :/
                            }
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
