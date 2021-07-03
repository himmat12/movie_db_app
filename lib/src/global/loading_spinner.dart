import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';

class LoadingSpinner {
  SpinKitFadingCircle fadingCircleSpinner = const SpinKitFadingCircle(
    // size: 14,
    color: primaryDarkBlue,
  );

  SpinKitThreeBounce horizontalLoading = const SpinKitThreeBounce(
    size: 14,
    color: primaryblue,
  );
}
