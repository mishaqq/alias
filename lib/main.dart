import 'dart:async';
import 'dart:math';

import 'package:alias/core/constants.dart';
import 'package:alias/dict/team_names.dart';
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

List<String> initTeams() {
  final random = Random();
  Set<String> initialTeams = {};

  while (initialTeams.length < 2) {
    String word = team_names[random.nextInt(team_names.length)];
    initialTeams.add(word);
  }

  return initialTeams.toList();
}

List<String> initTeamsAvatars() {
  final random = Random();
  Set<String> initialTeamsAvatars = {};

  while (initialTeamsAvatars.length < 2) {
    String image = images[random.nextInt(images.length)];
    initialTeamsAvatars.add(image);
  }

  return initialTeamsAvatars.toList();
}

final random = Random();
String word = team_names[random.nextInt(team_names.length)];

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
                    fontSize: 20.sp),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 10,

                  shadowColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 248, 237,
                      255), // Color.fromARGB(255, 255, 221, 149),
                  foregroundColor: Color.fromARGB(255, 255, 174, 0), //TO FIX
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: MediaQuery.of(context).size.height * 0.0024),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                          MediaQuery.of(context).size.height * 0.018),
                    ),
                  ),
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => MainPage(),
              '/score': (context) => ScorePage(),
              '/guessing': (context) => GuessingPage(),
              '/set_choosing': (context) => ChoosingPage(),
              '/settings': (context) => SettingsPage(fromGame: false),
              '/team': (context) => TeamPage(),
              '/rules': (context) => RulesPage(),
            },
          );
        });
  }
}

// TO DO Fix last word == false