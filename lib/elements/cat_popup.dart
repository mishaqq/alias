import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:typewritertext/typewritertext.dart';

class LCatPopUp extends StatelessWidget {
  const LCatPopUp({
    super.key,
    required this.text,
    required this.h,
    required this.w,
    required this.controller,
  });

  final double h;
  final double w;
  final Animation<double> controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: controller.value,
      left: w * 0.15,
      child: Container(
        width: w * 0.7,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 248, 237, 255),
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(w * 0.035),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                "assets/images/taping_cat.gif",
                height: h * 0.04,
              ),
            ),
            Center(
              child: SizedBox(
                width: w * 0.45,
                child: TypeWriter.text(
                  text,
                  maintainSize: false,
                  duration: const Duration(milliseconds: 50),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16.sp, height: 0.0.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
