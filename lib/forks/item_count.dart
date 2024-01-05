import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

typedef CounterChangeCallback = void Function(num value);

// ignore: must_be_immutable
class ItemCount extends StatelessWidget {
  final CounterChangeCallback onChanged;

  ItemCount({
    Key? key,
    required num initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    required this.decimalPlaces,
    this.color,
    this.textStyle,
    this.step = 1,
    this.buttonSizeWidth = 30,
    this.buttonSizeHeight = 25,
  })  : assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color? color;

  /// text syle
  TextStyle? textStyle;

  final double buttonSizeWidth, buttonSizeHeight;

  void _incrementCounter() {
    if (selectedValue + step <= maxValue) {
      onChanged((selectedValue + step));
    }
  }

  void _decrementCounter() {
    if (selectedValue - step >= minValue) {
      onChanged((selectedValue - step));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _decrementCounter,
            child: SizedBox(
              width: buttonSizeWidth,
              height: buttonSizeHeight,
              child: Container(
                alignment: Alignment(1, 1),
                decoration: ShapeDecoration(
                    color: color ?? themeData.primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ))),
                child: const Center(
                  child: Text(
                    "–",
                    style: TextStyle(fontSize: 45),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Text(
                '${num.parse((selectedValue).toStringAsFixed(decimalPlaces))}',
                style: const TextStyle(
                  fontSize: 50,
                )),
          ),
          GestureDetector(
            onTap: _incrementCounter,
            child: SizedBox(
              width: buttonSizeWidth,
              height: buttonSizeHeight,
              child: Container(
                alignment: Alignment(1, 0),
                decoration: ShapeDecoration(
                    color: color ?? themeData.primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ))),
                child: const Center(
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
