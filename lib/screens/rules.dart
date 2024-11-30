import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RulesPage extends ConsumerStatefulWidget {
  const RulesPage({super.key});

  @override
  ConsumerState<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends ConsumerState<RulesPage> {
  bool isSecondContainerVisible = false;
  bool isContentVisible = false;
  List<bool> isSelected = [true, false];

  void _togleMenue() {
    setState(() {
      isSecondContainerVisible = !isSecondContainerVisible;
      if (isSecondContainerVisible) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            isContentVisible = true;
          });
        });
        return;
      }
      Future.delayed(const Duration(milliseconds: 150), () {
        setState(() {
          isContentVisible = false;
        });
      });
    });
  }

  Widget _getRulesContent() {
    List<Widget> rules = [
      Text(
        AppLocalizations.of(context)!.gameRules,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 20.sp,
            ),
      ),
      Text(
        "Туди, сюди",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 20.sp,
            ),
      ),
    ];

    return rules[isSelected.indexOf(true)];
  }

  @override
  Widget build(BuildContext context) {
    //final game = ref.watch(gameProvider);
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
              Stack(
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
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: h * 0.015,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              _getRulesContent(),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 20),
                              //   child: RichText(
                              //     textAlign: TextAlign.center,
                              //     text: TextSpan(
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .bodyMedium!
                              //           .copyWith(
                              //               fontSize: h * 0.025,
                              //               decoration:
                              //                   TextDecoration.underline,
                              //               fontStyle: FontStyle.italic),
                              //       children: [
                              //         // TextSpan(
                              //         //   text: "Privacy Policy",
                              //         //   recognizer: tapGestureRecognizer(
                              //         //     onTap: () => launch(
                              //         //         'https://github.com/mishaqq/alias-privacy/blob/main/privacy-policy.md',
                              //         //         isNewTab: true),
                              //         //   ),
                              //         // ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ////////////////////////// Second Container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 248, 237, 255),
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
                    width: isSecondContainerVisible ? w * 0.75 : 0,
                    height: h * 0.72,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: h * 0.015,
                        right: h * 0.015,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: h * 0.015,
                        ),
                        child: isContentVisible
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    ToggleButtons(
                                        borderWidth: 2.5,
                                        splashColor: Colors.transparent,
                                        borderColor: Colors.black,
                                        fillColor: const Color.fromARGB(
                                            255, 255, 221, 149),
                                        selectedBorderColor: Colors.black,
                                        constraints: BoxConstraints(
                                          minWidth: w * 0.7,
                                          minHeight: h * 0.065,
                                        ),
                                        direction: Axis.vertical,
                                        isSelected: isSelected,
                                        onPressed: (index) {
                                          setState(() {
                                            for (int i = 0;
                                                i < isSelected.length;
                                                i++) {
                                              isSelected[i] = i == index;
                                            }

                                            _togleMenue();
                                          });
                                        },
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Базові правила",
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 18.sp,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "Останнє слово для всіх",
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 18.sp,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      height: 1.2),
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ),
                ],
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
                            _togleMenue();
                          },
                          child: Icon(
                            Icons.menu_outlined,
                            size: 20.sp,
                          ),
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

TapGestureRecognizer tapGestureRecognizer({
  required VoidCallback onTap,
}) {
  return TapGestureRecognizer()..onTap = onTap;
}

Future<void> launch(String url, {bool isNewTab = true}) async {
  if (await launchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }
}
