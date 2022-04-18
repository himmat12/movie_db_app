import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../configs/color_config.dart';
import '../configs/configs.dart';

class LoadingSpinner {
  SpinKitFadingCircle fadingCircleSpinner = const SpinKitFadingCircle(
    // size: 14,
    color: primaryDarkBlue,
  );

  SpinKitFadingCircle miniFadingCircleSpinner = const SpinKitFadingCircle(
    size: 22,
    color: primaryWhite,
  );

  SpinKitThreeBounce horizontalLoading = const SpinKitThreeBounce(
    size: 14,
    color: primaryblue,
  );
}
