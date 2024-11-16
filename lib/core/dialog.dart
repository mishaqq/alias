import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/game_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showAlertDialog(BuildContext context, ref) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  Widget cancelButton = Padding(
    padding: EdgeInsets.only(left: w * 0.00),
    child: SizedBox(
      width: w * 0.25,
      height: w * 0.15,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 221, 149),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * 0.035),
            ),
            side: BorderSide(width: 2),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.leaveGame,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: "Anonymous",
              fontSize: 14.sp),
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
    height: w * 0.15,
    child: TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 221, 149),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width * 0.035),
          ),
          side: BorderSide(width: 2),
        ),
      ),
      child: Text(
        AppLocalizations.of(context)!.no,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: "Anonymous",
            fontSize: 14.sp),
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
    actionsPadding: EdgeInsets.only(right: w * 0.0, bottom: w * 0.07),
    title: Center(
      child: Text(
        AppLocalizations.of(context)!.leaveGameTitle,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: "Anonymous",
            fontSize: 18.sp),
      ),
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
