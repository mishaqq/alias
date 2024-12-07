import 'package:alias/dict/en_word_sets.dart';
import 'package:alias/models/set_model.dart';
import 'package:alias/utils/helper_functions.dart';

//TODO : auto example random words from set
List<AliasSet> enSetsList = [
  AliasSet(
    id: "basic",
    title: "Basic words",
    contents: removeRepetitionsFromSet(basic),
    example: initExanpleWords(
      basic,
      wordsQuantity: 4,
    ),
  ),
  AliasSet(
    id: "expert",
    title: "Expert",
    contents: removeRepetitionsFromSet(expert),
    example: initExanpleWords(
      expert,
      wordsQuantity: 4,
    ),
  ),
  AliasSet(
    id: "films",
    title: "Movies",
    contents: removeRepetitionsFromSet(popularFilms),
    example: initExanpleWords(
      popularFilms,
      wordsQuantity: 3,
    ),
  ),
  AliasSet(
    id: "slang",
    title: "Slang",
    contents: removeRepetitionsFromSet(slang),
    example: initExanpleWords(
      slang,
      wordsQuantity: 4,
    ),
  ),
  AliasSet(
    id: "gameWords",
    title: "Gamers dictionary",
    contents: removeRepetitionsFromSet(gamersSlang),
    example: initExanpleWords(
      gamersSlang,
      wordsQuantity: 4,
    ),
  ),
  AliasSet(
    id: "space",
    title: "Space related",
    contents: removeRepetitionsFromSet(space),
    example: initExanpleWords(
      space,
      wordsQuantity: 4,
    ),
  ),
];
