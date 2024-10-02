import 'package:alias/models/set_model.dart';
import 'package:flutter/material.dart';

class SetLocalizationModel {
  final Map<Locale, List<AliasSet>> localizedSetList;

  const SetLocalizationModel({
    required this.localizedSetList,
  });
}
