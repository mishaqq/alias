import 'package:alias/core/en_sets_list.dart';
import 'package:alias/core/uk_sets_list.dart';
import 'package:alias/models/set_localization_model.dart';
import 'package:alias/models/set_model.dart';
import 'package:flutter/material.dart';

import '../dict/uk_word_sets.dart';

final setLocalizationModel = SetLocalizationModel(localizedSetList: {
  const Locale('uk'): ukSetsList,
  const Locale('en'): enSetsList,
});

List<String> images = [
  "assets/images/gost.jpg",
  "assets/images/claus.jpg",
  "assets/images/duck.jpg",
  "assets/images/crab.jpg",
  "assets/images/green.jpg",
  "assets/images/hai.jpg",
  "assets/images/panda.jpg",
  "assets/images/plate.jpg",
  "assets/images/pumpkin.jpg",
  "assets/images/sapce.jpg",
  "assets/images/snowman.jpg",
  "assets/images/vampire.jpg",
  "assets/images/wale.jpg",
];
// final List<String> SETS = ["basic", "expert", "ukr", "tworoots", "slang"];
// final Map<String, String> title = {
//   "basic": "Базові слова",
//   "expert": "Експерт",
//   "ukr": "Файні українські слова",
//   "tworoots": "Складні слова",
//   "slang": "Молодіжний сленг",
// };

// final Map<String, String> example = {
//   "basic": "кіт, корабель, вино...",
//   "expert": "багатогранний, чаклун, дискусія...",
//   "ukr": "ґава, ятрити, говірка...",
//   "tworoots": "фотосинтез, шибайголова, зорепад...",
//   "slang": "твіт, казуал, зашквар...",
// };

// Map<String, List<String>> setsTable = {
//   "basic": basic,
//   "expert": expert,
//   "ukr": ukr,
//   "tworoots": tworoots,
//   "slang": slang,
// };


// List<Image> cachimages = [
//   Image.asset("assets/images/gost.jpg"),
//   Image.asset("assets/images/claus.jpg"),
//   Image.asset("assets/images/duck.jpg"),
//   Image.asset("assets/images/crab.jpg"),
//   Image.asset("assets/images/green.jpg"),
//   Image.asset("assets/images/hai.jpg"),
//   Image.asset("assets/images/panda.jpg"),
//   Image.asset("assets/images/plate.jpg"),
//   Image.asset("assets/images/pumpkin.jpg"),
//   Image.asset("assets/images/sapce.jpg"),
//   Image.asset("assets/images/snowman.jpg"),
//   Image.asset("assets/images/vampire.jpg"),
//   Image.asset("assets/images/wale.jpg"),
// ];

