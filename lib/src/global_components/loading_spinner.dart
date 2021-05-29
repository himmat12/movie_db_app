import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:get/get.dart';

class LoadingSpinner {
  static SpinKitFadingCircle fadingCircleSpinner = const SpinKitFadingCircle(
    // size: 14,
    color: primaryDarkBlue,
  );

  static SpinKitThreeBounce horizontalLoading = const SpinKitThreeBounce(
    size: 14,
    color: primaryblue,
  );
}
