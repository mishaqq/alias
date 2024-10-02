import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Providet to save current locale in order to acsess AppLocalizations without context
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale("uk"));

  void updateLocale(Locale newLocale) {
    state = newLocale;
  }

  // Function to get localization without context
  AppLocalizations getLocalization() {
    return lookupAppLocalizations(state);
  }
}
