import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Alias'**
  String get appTitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageTitle;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @newGameButton.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGameButton;

  /// No description provided for @rulesButton.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rulesButton;

  /// No description provided for @gameRules.
  ///
  /// In en, this message translates to:
  /// **'1. Teams take turns playing. A minimum of two players in each team.\n\n2. One player must explain words to their team. The other team members guess.\n\n3. You are not allowed to use any part of the word when explaining, nor words with the same root. For example, you cannot explain the word \'banker\' as \'a person who works in a bank\', because \'bank\' and \'banker\' share the same root.\n\nWords cannot be explained in foreign languages unless the players agree on this before the game starts.\n\n4. The number of correctly guessed words equals the number of points. Mistakes and unclear words will deduct points.\n\n5. If \'Last word for all\' is enabled, the word at the end of the time can be guessed by any team.\n\n6. A team wins when it earns enough points to win (defined in the settings).'**
  String get gameRules;

  /// No description provided for @words.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get words;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @durationTitle.
  ///
  /// In en, this message translates to:
  /// **'Round duration:'**
  String get durationTitle;

  /// No description provided for @wordsToWinTitle.
  ///
  /// In en, this message translates to:
  /// **'Words to win:'**
  String get wordsToWinTitle;

  /// No description provided for @lastWordTitle.
  ///
  /// In en, this message translates to:
  /// **'Last word for all:'**
  String get lastWordTitle;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @acceptButton.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptButton;

  /// No description provided for @teamsTitle.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teamsTitle;

  /// No description provided for @addTeamButton.
  ///
  /// In en, this message translates to:
  /// **'Add Team'**
  String get addTeamButton;

  /// No description provided for @nextRoundButton.
  ///
  /// In en, this message translates to:
  /// **'Next Round'**
  String get nextRoundButton;

  /// No description provided for @currentTurn.
  ///
  /// In en, this message translates to:
  /// **'Now:'**
  String get currentTurn;

  /// No description provided for @whoGuessed.
  ///
  /// In en, this message translates to:
  /// **'Who is so smart?'**
  String get whoGuessed;

  /// No description provided for @nobody.
  ///
  /// In en, this message translates to:
  /// **'Nobody'**
  String get nobody;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @oneWinner.
  ///
  /// In en, this message translates to:
  /// **'won!'**
  String get oneWinner;

  /// No description provided for @twoWinners.
  ///
  /// In en, this message translates to:
  /// **'won, it\'s a draw!'**
  String get twoWinners;

  /// No description provided for @moreThenTwoWinners.
  ///
  /// In en, this message translates to:
  /// **'Everyone won, it\'s a draw!'**
  String get moreThenTwoWinners;

  /// No description provided for @leaveGame.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leaveGame;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @leaveGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Quit this game?'**
  String get leaveGameTitle;

  /// No description provided for @catPopup.
  ///
  /// In en, this message translates to:
  /// **'Swipe cards to change language.'**
  String get catPopup;

  /// No description provided for @wordsAmount.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get wordsAmount;

  /// No description provided for @nothingSelected.
  ///
  /// In en, this message translates to:
  /// **'Well, go ahead and choose something...'**
  String get nothingSelected;

  /// No description provided for @emptySets.
  ///
  /// In en, this message translates to:
  /// **'Swipe or start the new game...'**
  String get emptySets;

  /// No description provided for @wordForAll.
  ///
  /// In en, this message translates to:
  /// **'Word for all'**
  String get wordForAll;

  /// No description provided for @basicRules.
  ///
  /// In en, this message translates to:
  /// **'Basic rules'**
  String get basicRules;

  /// No description provided for @lastWordForAll.
  ///
  /// In en, this message translates to:
  /// **'Last word for all'**
  String get lastWordForAll;

  /// No description provided for @isNoMinusPoints.
  ///
  /// In en, this message translates to:
  /// **'Minus for skipping: '**
  String get isNoMinusPoints;

  /// No description provided for @lastWordRools.
  ///
  /// In en, this message translates to:
  /// **'1. At the end of each round, when the time is up, the word on the last card can be guessed by any team.\n\n2. The explainer must clearly and loudly explain the last word to all players.\n\n3. After a team guesses the last word, you need to click on that team in the last word menu to assign them points for the last word.\n\n4. At the end of the round, you can always change which team gets the points for the last word.'**
  String get lastWordRools;

  /// No description provided for @scoreCountingTittle.
  ///
  /// In en, this message translates to:
  /// **'Calculation of points'**
  String get scoreCountingTittle;

  /// No description provided for @scoreCountingBody.
  ///
  /// In en, this message translates to:
  /// **'1. Tap on the words in the list to toggle their status between “guessed” and “not guessed”.\n\n2. If the “Last Word for Everyone” mode is enabled, you can change which team receives the points for the last word by tapping on it.\n\n3. If the “Minus for skipping” feature is activated, each skipped word deducts one point, but the total score for the round cannot drop below 0.'**
  String get scoreCountingBody;

  /// No description provided for @gameFlowTittle.
  ///
  /// In en, this message translates to:
  /// **'Game flow'**
  String get gameFlowTittle;

  /// No description provided for @gameFlowBody.
  ///
  /// In en, this message translates to:
  /// **'1. The current team\'s picture is highlighted with a black circle, and the bottom of the screen displays “Now: ” followed by the team\'s name.\n\n2. Even if a team scores enough points to win, they will not be declared the winner until all teams have played one full round.\n\n3. If more than one team scores enough points to win, the team with the highest score will be declared the winner.'**
  String get gameFlowBody;

  /// No description provided for @countBackArrow.
  ///
  /// In en, this message translates to:
  /// **'There\'s only forward here, sparrow.'**
  String get countBackArrow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
