import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Providet to save current locale in order to acsess AppLocalizations without context
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale("uk"));

  void updateLocale(Locale newLocale) {
    state = newLocale;

    _saveCurLocaleToSP();
  }

  // Function to get localization without context
  AppLocalizations getLocalization() {
    return lookupAppLocalizations(state);
  }

  Future<void> initLocale(List<Locale> systemDefault) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // log(state.toLanguageTag());

    final String? curLocaleCode = pref.getString("curLocale");
    if (curLocaleCode != null) {
      log("Saved cur locale code in SP: $curLocaleCode");
      state = Locale(curLocaleCode);
    } else {
      // no locale saved in SP
      final prefixSystemDefault =
          systemDefault.map((locale) => locale.languageCode).toList();

      if (!prefixSystemDefault.contains('uk') ||
          !prefixSystemDefault.contains('ru')) {
        state = const Locale("en");
      }
    }
    _saveCurLocaleToSP();
  }

  Future<bool> ifCatPopup() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // what is the difference beetwen Bool and bool
    final bool? isCat = pref.getBool("catPopup");
    if (isCat != null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> _saveCurLocaleToSP() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    log("Locale code saved to SP: ${state.toLanguageTag()}");
    pref.setString("curLocale", state.toLanguageTag());
  }
}
