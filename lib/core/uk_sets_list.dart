import 'package:alias/dict/uk_word_sets.dart';
import 'package:alias/models/set_model.dart';

const List<AliasSet> ukSetsList = [
  AliasSet(
      id: "basic",
      title: "Базові слова",
      contents: basic,
      example: "кіт, корабель, вино"),
  AliasSet(
      id: "expert",
      title: "Експерт",
      contents: expert,
      example: "багатогранний, чаклун, дискусія"),
  AliasSet(
      id: "ukr",
      title: "Файні українські слова",
      contents: ukr,
      example: "ґава, ятрити, говірка"),
  AliasSet(
      id: "tworoots",
      title: "Складні слова",
      contents: tworoots,
      example: "фотосинтез, шибайголова, зорепад"),
  AliasSet(
      id: "slang",
      title: "Молодіжний сленг",
      contents: slang,
      example: "твіт, казуал, зашквар"),
  AliasSet(
      id: "test",
      title: "Меми",
      contents: test,
      example: "Штани за 40 гривень, Астанавітєсь!"),
];
