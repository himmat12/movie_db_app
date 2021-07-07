import 'package:flutter/material.dart';

class SizeConfig {
  late MediaQueryData mediaQueryData;
  late double screenHeight;
  late double screenWidth;
  late double blockVerticalHeight;
  late double blockHorizontalWidth;

  void initSize(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenHeight = mediaQueryData.size.height;
    screenWidth = mediaQueryData.size.width;
    blockVerticalHeight = screenHeight / 100;
    blockHorizontalWidth = screenWidth / 100;
  }
}
