import 'dart:math';

import 'package:alias/providers/locale_provider.dart';
import 'package:alias/screens/guessing_page.dart';
import 'package:alias/screens/main_page.dart';
import 'package:alias/screens/rules.dart';
import 'package:alias/screens/setSelection_page.dart';
import 'package:alias/screens/settings_page.dart';
import 'package:alias/screens/team_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/score_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // ;ocale
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // locale

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            theme: ThemeData(
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: "Anonymous",
                  fontSize:
                      MediaQuery.of(context).size.width < 720 ? 20.sp : 34,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 10,

                  shadowColor: const Color.fromARGB(255, 30, 62, 187),
                  backgroundColor: const Color.fromARGB(255, 248, 237,
                      255), // Color.fromARGB(255, 255, 221, 149),
                  foregroundColor: Color.fromARGB(255, 255, 174, 0),
                  overlayColor: Color.fromARGB(255, 255, 174, 0), //TO FIX
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                          MediaQuery.of(context).size.width * 0.035),
                    ),
                  ),
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('uk'), // Ukrainian
            ],
            locale: ref.watch(
              localeProvider,
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => const MainPage(),
              '/score': (context) => const ScorePage(),
              '/guessing': (context) => const GuessingPage(),
              '/set_choosing': (context) => const ChoosingPage(),
              '/settings': (context) => const SettingsPage(fromGame: false),
              '/team': (context) => const TeamPage(),
              '/rules': (context) => const RulesPage(),
            },
          );
        });
  }
}

// TO DO Fix last word == false