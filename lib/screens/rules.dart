import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RulesPage extends ConsumerWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: h * 0.015,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.gameRules,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: h * 0.018,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: h * 0.025,
                                        decoration: TextDecoration.underline,
                                        fontStyle: FontStyle.italic),
                                children: [
                                  TextSpan(
                                    text: "Privacy Policy",
                                    recognizer: tapGestureRecognizer(
                                      onTap: () => launch(
                                          'https://github.com/mishaqq/alias-privacy/blob/main/privacy-policy.md',
                                          isNewTab: true),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      width: w * 0.85,
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
