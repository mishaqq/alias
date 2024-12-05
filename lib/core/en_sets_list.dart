import 'package:alias/dict/en_word_sets.dart';
import 'package:alias/models/set_model.dart';
import 'package:alias/utils/helper_functions.dart';

//TODO : auto example random words from set
List<AliasSet> enSetsList = [
  AliasSet(
      id: "basic",
      title: "Basic Words",
      contents: removeRepetitionsFromSet(basic),
      example: "flower, worm, dance"),
];
