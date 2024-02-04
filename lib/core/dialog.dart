import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game_model_provider.dart';

showAlertDialog(BuildContext context, ref) {
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      ref.read(gameProvider.notifier).oldSesionTrue();
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Leave curent game?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
