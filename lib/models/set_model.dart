import 'package:flutter/foundation.dart';

class AliasSet {
  final String title;
  final String id;
  final String example;
  final List<String> contents;

  const AliasSet({
    required this.id,
    required this.title,
    required this.example,
    required this.contents,
  });
}
