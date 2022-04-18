import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../configs/configs.dart';
import '../controllers/utility_controller.dart';

Widget externalIdBtn({
  required String targetUrl,
  required String asset,
  double? height = 22,
  double? width = 22,
  BoxFit fit = BoxFit.scaleDown,
  Color? color,
}) {
  final _utilityController = Get.find<UtilityController>();

  return GestureDetector(
    onTap: () {
      _utilityController.loadUrl(url: targetUrl);
    },
    child: SvgPicture.asset(
      'assets/$asset',
      height: height,
      width: width,
      color: color ?? primaryDarkBlue.withOpacity(0.8),
      fit: fit,
    ),
  );
}
