// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Alias';

  @override
  String get languageTitle => 'English';

  @override
  String get continueButton => 'Continue';

  @override
  String get newGameButton => 'New Game';

  @override
  String get rulesButton => 'Rules';

  @override
  String get gameRules =>
      '1. Teams take turns playing. A minimum of two players in each team.\n\n2. One player must explain words to their team. The other team members guess.\n\n3. You are not allowed to use any part of the word when explaining, nor words with the same root. For example, you cannot explain the word \'banker\' as \'a person who works in a bank\', because \'bank\' and \'banker\' share the same root.\n\nWords cannot be explained in foreign languages unless the players agree on this before the game starts.\n\n4. The number of correctly guessed words equals the number of points. Mistakes and unclear words will deduct points.\n\n5. If \'Last word for all\' is enabled, the word at the end of the time can be guessed by any team.\n\n6. A team wins when it earns enough points to win (defined in the settings).';

  @override
  String get words => 'Sets';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get durationTitle => 'Round duration:';

  @override
  String get wordsToWinTitle => 'Words to win:';

  @override
  String get lastWordTitle => 'Last word for all:';

  @override
  String get backButton => 'Back';

  @override
  String get acceptButton => 'Accept';

  @override
  String get teamsTitle => 'Teams';

  @override
  String get addTeamButton => 'Add Team';

  @override
  String get nextRoundButton => 'Next Round';

  @override
  String get currentTurn => 'Now:';

  @override
  String get whoGuessed => 'Who is so smart?';

  @override
  String get nobody => 'Nobody';

  @override
  String get next => 'Next';

  @override
  String get oneWinner => 'won!';

  @override
  String get twoWinners => 'won, it\'s a draw!';

  @override
  String get moreThenTwoWinners => 'Everyone won, it\'s a draw!';

  @override
  String get leaveGame => 'Leave';

  @override
  String get no => 'No';

  @override
  String get leaveGameTitle => 'Quit this game?';

  @override
  String get catPopup => 'Swipe cards to change language.';

  @override
  String get wordsAmount => 'Words';

  @override
  String get nothingSelected => 'Well, go ahead and choose something...';

  @override
  String get emptySets => 'Swipe or start the new game...';

  @override
  String get wordForAll => 'Word for all';

  @override
  String get basicRules => 'Basic rules';

  @override
  String get lastWordForAll => 'Last word for all';

  @override
  String get isNoMinusPoints => 'Minus for skipping: ';

  @override
  String get lastWordRools =>
      '1. At the end of each round, when the time is up, the word on the last card can be guessed by any team.\n\n2. The explainer must clearly and loudly explain the last word to all players.\n\n3. After a team guesses the last word, you need to click on that team in the last word menu to assign them points for the last word.\n\n4. At the end of the round, you can always change which team gets the points for the last word.';

  @override
  String get scoreCountingTittle => 'Calculation of points';

  @override
  String get scoreCountingBody =>
      '1. Tap on the words in the list to toggle their status between “guessed” and “not guessed”.\n\n2. If the “Last Word for Everyone” mode is enabled, you can change which team receives the points for the last word by tapping on it.\n\n3. If the “Minus for skipping” feature is activated, each skipped word deducts one point, but the total score for the round cannot drop below 0.';

  @override
  String get gameFlowTittle => 'Game flow';

  @override
  String get gameFlowBody =>
      '1. The current team\'s picture is highlighted with a black circle, and the bottom of the screen displays “Now: ” followed by the team\'s name.\n\n2. Even if a team scores enough points to win, they will not be declared the winner until all teams have played one full round.\n\n3. If more than one team scores enough points to win, the team with the highest score will be declared the winner.';

  @override
  String get countBackArrow => 'There\'s only forward here, sparrow.';
}
