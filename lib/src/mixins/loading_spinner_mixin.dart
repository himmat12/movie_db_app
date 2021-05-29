import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/src/configs/configs.dart';

mixin LoadingSpinnerMixin {
  final fadingCircleSpinner = const SpinKitFadingCircle(
    size: 14,
    color: primaryDarkBlue,
  );
  final horizontalLoading = const SpinKitThreeBounce(
    size: 14,
    color: primaryblue,
  );
}
