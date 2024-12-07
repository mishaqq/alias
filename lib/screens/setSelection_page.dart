import 'package:alias/core/constants.dart';
import 'package:alias/elements/cat_popup.dart';
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

class _GuessingPageState extends ConsumerState<ChoosingPage>
    with TickerProviderStateMixin {
  late List<AliasSet> localizedSetList;
  late AnimationController _controllerCat;
  late Animation<double> _catAnimationController;
  late OverlayPortalController overlayPortalController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    Locale curLocale = ref.read(localeProvider);
    localizedSetList = setLocalizationModel.localizedSetList[curLocale]!;

    overlayPortalController = OverlayPortalController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _scrollController.animateTo(
        MediaQuery.of(context).size.width * 0.065,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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

  final MultiSelectController<AliasSet> _controller = MultiSelectController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OverlayPortal(
        controller: overlayPortalController,
        overlayChildBuilder: (context) => AnimatedBuilder(
          animation: _catAnimationController,
          builder: (context, child) => LCatPopUp(
            text: AppLocalizations.of(context)!.nothingSelected,
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
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.01),
                        child: Text(
                          AppLocalizations.of(context)!.words,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 24.sp,
                                  ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: h * 0.015,
                            right: h * 0.015,
                          ),
                          child: MultiSelectCheckList(
                            chechboxScaleFactor: 1,
                            itemPadding: EdgeInsets.all(w * 0.025),
                            maxSelectableCount: localizedSetList.length,
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
                              controller: _scrollController,
                              padding: EdgeInsets.only(
                                bottom: h * 0.01,
                                top: h * 0.04,
                              ),
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(
                                height: w * 0.025,
                              ),
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
                                title: Text(
                                  localizedSetList[index].title,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: w * 0.015),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${localizedSetList[index].contents.length} ${AppLocalizations.of(context)!.wordsAmount}", //TODO : Translate
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: w * 0.005),
                                        child: Wrap(
                                          children: [
                                            Text(
                                              localizedSetList[index].example,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    162, 0, 0, 0),
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
                                selectedColor:
                                    Color.fromARGB(255, 248, 237, 255),
                                checkColor: Colors.black,
                                checkBoxGap: w * 0.01,
                                leadingCheckBox: false,
                                checkBoxBorderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
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
                              backgroundColor:
                                  Color.fromARGB(255, 255, 221, 149),
                            ),
                            onPressed: () {
                              if (_controller.getSelectedItems().isNotEmpty) {
                                ref.read(gameProvider.notifier).makeGameWordSet(
                                    _controller.getSelectedItems());

                                Navigator.pushNamed(context, "/settings");
                              } else {
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
      ),
    );
  }
}
