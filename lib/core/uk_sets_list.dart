import 'dart:math';

import 'package:alias/dict/uk_word_sets.dart';
import 'package:alias/models/set_model.dart';
import 'package:alias/utils/helper_functions.dart';

List<AliasSet> ukSetsList = [
  AliasSet(
      id: "basic",
      title: "Базові слова",
      contents: removeRepetitionsFromSet(basic),
      example: initExanpleWords(
        basic,
        wordsQuantity: 4,
      )),
  AliasSet(
      id: "expert",
      title: "Експерт",
      contents: removeRepetitionsFromSet(expert),
      example: initExanpleWords(expert)),
  AliasSet(
    id: "slang",
    title: "Молодіжний сленг",
    contents: removeRepetitionsFromSet(slang),
    example: initExanpleWords(
      slang,
      wordsQuantity: 4,
    ),
  ),
  AliasSet(
    id: "test",
    title: "Меми",
    contents: removeRepetitionsFromSet(memes),
    example: initExanpleWords(
      memes,
      wordsQuantity: 2,
    ),
  ),
  AliasSet(
      id: "ukr",
      title: "Забуті українські слова",
      contents: removeRepetitionsFromSet(ukr),
      example: initExanpleWords(ukr)),
  AliasSet(
    id: "tworoots",
    title: "Складні слова",
    contents: removeRepetitionsFromSet(tworoots),
    example: initExanpleWords(tworoots),
  ),
  AliasSet(
    id: "space",
    title: "Космос",
    contents: removeRepetitionsFromSet(space),
    example: initExanpleWords(space),
  ),
];
