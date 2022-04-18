import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../configs/configs.dart';

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
