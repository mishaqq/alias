// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Eліас';

  @override
  String get languageTitle => 'Українською';

  @override
  String get continueButton => 'Продовжити';

  @override
  String get newGameButton => 'Нова гра';

  @override
  String get rulesButton => 'Правила';

  @override
  String get gameRules =>
      '1. Команди грають по черзі. Мінімум два гравця в кожній.\n\n2. Один гравець має пояснювати слова для своєї команди. Інші члени команди вгадують.\n\n3. Ви не маєте права використовувати будь-яку частину слова, коли ви пояснюєте, а також слова з одним коренем. Наприклад слово “автобус” не можна пояснити як “автомобільний транспортний засіб”. Ви можете сказати “маршрутний транспортний засіб”.\n\nВи не можете пояснити слово “банкір” як “людина, яка працює в банку”, тому що слова “банк” та “банкір” мають спільний корінь.\n\nСлова не можна пояснювати іноземними мовами, якщо про це гравці не домовилися перед початком гри.\n\n4. Кількість вгаданих слів відповідає кількості пунктів. Зроблені помилки і незрозумілі слова забирають пункти.\n\n5. Якщо ввімкнене “Останнє слово для всіх”, то слово на момент закінчення часу в раунді може вгадувати будь-яка команда.\n\n6. Команда перемагає коли набирає достатню кількість пунктів для перемоги (визначається в налаштуваннях).\n\nНавіть якщо якась команда набирає достатню кількість балів для перемоги, гра продовжується поки всі інші команди не закінчать теперішній раунд.';

  @override
  String get words => 'Слова';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get durationTitle => 'Тривалість раунду:';

  @override
  String get wordsToWinTitle => 'Слів до перемоги:';

  @override
  String get lastWordTitle => 'Останнє слово для всіх:';

  @override
  String get backButton => 'Назад';

  @override
  String get acceptButton => 'Перейняти';

  @override
  String get teamsTitle => 'Команди';

  @override
  String get addTeamButton => 'Додати команду';

  @override
  String get nextRoundButton => 'Наступний раунд';

  @override
  String get currentTurn => 'Зараз:';

  @override
  String get whoGuessed => 'Хто такий розумний?';

  @override
  String get nobody => 'Ніхто';

  @override
  String get next => 'Далі';

  @override
  String get oneWinner => 'перемогли!';

  @override
  String get twoWinners => 'перемогли, це нічия!';

  @override
  String get moreThenTwoWinners => 'Всі перемогли, це нічия!';

  @override
  String get leaveGame => 'Вийти';

  @override
  String get no => 'Ні';

  @override
  String get leaveGameTitle => 'Вийти з цієї гри?';

  @override
  String get catPopup => 'Свайпни картки щоб змінити мову.';

  @override
  String get wordsAmount => 'Слів';

  @override
  String get nothingSelected => 'Та вибери ти хоч щось...';

  @override
  String get emptySets => 'Тут тільки нову гру починати...';

  @override
  String get wordForAll => 'Слово для всіх';

  @override
  String get basicRules => 'Базові правила';

  @override
  String get lastWordForAll => 'Останнє слово для всіх';

  @override
  String get isNoMinusPoints => 'Мінус за скіп слів: ';

  @override
  String get lastWordRools =>
      '1. В кінці кожного раунду, коли час вийшов, слово на останній картці може відгадувати кожна команда.\n\n2. Той хто пояснює, має чітко і голосно пояснювати останнє слово всім гравцям.\n\n3. Після того як якась команда відгадала останнє слово, треба натиснути на неї у меню останнього слова, щоб зарахувати їй бали за останнє слово.\n\n4. В кінці раунду можна завжди змінити кому зараховуються бали за останнє слово.';

  @override
  String get scoreCountingTittle => 'Підрахунок балів';

  @override
  String get scoreCountingBody =>
      '1. Натискайте на слова у списку, щоб змінювати їхній статус між “вгадано” та “не вгадано”.\n\n2. Якщо увімкнено режим “Останнє слово для всіх”, можна змінити кому зараховуються бали за останнє слово, натиснувши на нього.\n\n3. Якщо активовано “Мінус пункти за свайп”, кожне пропущене слово знімає один бал, але кількість балів за раунд не може впасти нижче 0.';

  @override
  String get gameFlowTittle => 'Хід гри';

  @override
  String get gameFlowBody =>
      '1. Картинка команди, яка зараз грає виділена чорним кружечком і знизу екрану написано “Зараз: ” + її назва.\n\n2. Навіть якщо якась команда набрала достатню для перемоги кількість балів, вона не переможе доки всі команди не зіграють одне повне коло.\n\n3. Якщо більше ніж одна команда набрала достатню для перемоги кількість балів, переможе та, у якої найбільша кількість балів.';

  @override
  String get countBackArrow => 'Тут тільки далі, горобець.';
}
