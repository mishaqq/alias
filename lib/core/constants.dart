import '../dict/word_sets.dart';

final List<String> SETS = ["basic", "expert", "ukr", "tworoots", "slang"];
final Map<String, String> title = {
  "basic": "Базові слова",
  "expert": "Експерт",
  "ukr": "Файні українські слова",
  "tworoots": "Складні слова",
  "slang": "Молодіжний сленг",
};

final Map<String, String> example = {
  "basic": "кіт, корабель, вино...",
  "expert": "багатогранний, чаклун, дискусія...",
  "ukr": "ґава, ятрити, говірка...",
  "tworoots": "фотосинтез, шибайголова, зорепад...",
  "slang": "твіт, казуал, зашквар...",
};

Map<String, List<String>> setsTable = {
  "basic": basic,
  "expert": expert,
  "ukr": ukr,
  "tworoots": tworoots,
  "slang": slang,
};
