import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game_model_provider.dart';

showAlertDialog(BuildContext context, ref) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  Widget cancelButton = TextButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 255, 221, 149),
      side: BorderSide(width: MediaQuery.of(context).size.height * 0.0024),
    ),
    child: Text(
      "Вийти",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: "Anonymous",
          fontSize: w * 0.040),
    ),
    onPressed: () {
      ref.read(gameProvider.notifier).oldSesionTrue();
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
  );
  Widget continueButton = TextButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 255, 221, 149),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: MediaQuery.of(context).size.height * 0.0024),
      ),
    ),
    child: Text(
      "Продовжити",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: "Anonymous",
          fontSize: w * 0.040),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: h * 0.0024),
      borderRadius: BorderRadius.all(
        Radius.circular(h * 0.018),
      ),
    ),
    actionsAlignment: MainAxisAlignment.end,
    actionsPadding: EdgeInsets.only(right: w * 0.02, bottom: w * 0.03),
    title: Text(
      "Вийти з цієї гри?",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: "Anonymous",
          fontSize: w * 0.047),
    ),
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
