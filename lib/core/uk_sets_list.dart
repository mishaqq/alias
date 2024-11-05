import 'dart:math';

import 'package:alias/dict/uk_word_sets.dart';
import 'package:alias/models/set_model.dart';
import 'package:alias/utils/helper_functions.dart';

List<AliasSet> ukSetsList = [
  AliasSet(
      id: "basic",
      title: "Базові слова",
      contents: basic,
      example: initExanpleWords(
        basic,
        wordsQuantity: 4,
      )),
  AliasSet(
      id: "expert",
      title: "Експерт",
      contents: expert,
      example: initExanpleWords(expert)),
  AliasSet(
    id: "slang",
    title: "Молодіжний сленг",
    contents: slang,
    example: initExanpleWords(
      slang,
      wordsQuantity: 4,
    ),
  ),
  AliasSet(
    id: "test",
    title: "Меми",
    contents: memes,
    example: initExanpleWords(
      memes,
      wordsQuantity: 2,
    ),
  ),
  AliasSet(
      id: "ukr",
      title: "Файні українські слова",
      contents: ukr,
      example: initExanpleWords(ukr)),
  AliasSet(
      id: "tworoots",
      title: "Складні слова",
      contents: tworoots,
      example: initExanpleWords(tworoots)),
];
