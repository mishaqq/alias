import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';

showAlertDialog(BuildContext context, ref) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  Widget cancelButton = Padding(
    padding: EdgeInsets.only(left: w * 0.00),
    child: SizedBox(
      width: w * 0.17,
      height: w * 0.1,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 221, 149),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(width: MediaQuery.of(context).size.height * 0.003),
          ),
        ),
        child: Text(
          "Вийти",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: "Anonymous",
              fontSize: 12.sp),
        ),
        onPressed: () {
          ref.read(gameProvider.notifier).oldSesionTrue();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    ),
  );
  Widget continueButton = SizedBox(
    width: w * 0.25,
    height: w * 0.1,
    child: TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 221, 149),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(width: MediaQuery.of(context).size.height * 0.003),
        ),
      ),
      child: Text(
        "Продовжити",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: "Anonymous",
            fontSize: 12.sp),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: h * 0.0024),
      borderRadius: BorderRadius.all(
        Radius.circular(h * 0.018),
      ),
    ),
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: EdgeInsets.only(right: w * 0.0, bottom: w * 0.03),
    title: Text(
      "Вийти з цієї гри?",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontFamily: "Anonymous",
          fontSize: 18.sp),
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
