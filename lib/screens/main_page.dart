import 'package:alias/providers/setsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../providers/game_model_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

bool oldSesion = false;

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    // when the page loads it reads from the SP if there was an old session and saves it to the Game Provider state
    ref.read(gameProvider.notifier).oldGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    oldSesion = ref.watch(gameProvider).oldSesion;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (oldSesion)
              ElevatedButton(
                onPressed: () async {
                  // fetches the data from SP to Game Provider
                  await ref.read(gameProvider.notifier).readFormPrefs();

                  // makes a list of words for the current game
                  ref
                      .read(gameProvider.notifier)
                      .makeGameWordSet(ref.read(gameProvider).setsNames);

                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, '/score');
                },
                child: const Text("Continue"),
              )
            else
              const SizedBox(),
            ElevatedButton(
              onPressed: () async {
                ref.read(gameProvider.notifier).reset();
                Navigator.pushNamed(context, '/set_choosing');
              },
              child: const Text("Start Game!"),
            ),

            ///
            /// Button for testing purposes
            /// Clearing the SP

            // ElevatedButton(
            //   onPressed: () async {

            //     final SharedPreferences pref =
            //         await SharedPreferences.getInstance();
            //     await pref.remove("oldSesion");
            //     setState(() {});
            //   },
            //   child: Text("Clear"),
            // ),
          ],
        ),
      ),
    );
  }
}
