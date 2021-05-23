import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double screenHeight;
  static late double screenWidth;
  static late double blockVerticalHeight;
  static late double blockHorizontalWidth;

  static initSize(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData.size.height;
    screenWidth = mediaQueryData.size.width;
    blockVerticalHeight = screenHeight / 100;
    blockHorizontalWidth = screenWidth / 100;
  }
}
