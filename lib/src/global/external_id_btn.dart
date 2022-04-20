import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../configs/configs.dart';
import '../controllers/utility_controller.dart';

class ExternalIdBtn extends StatelessWidget {
  ExternalIdBtn({
    required this.targetUrl,
    required this.asset,
    this.height = 22,
    this.width = 22,
    this.color,
    this.fit = BoxFit.scaleDown,
    Key? key,
  }) : super(key: key);

  final String targetUrl;
  final String asset;
  final double height;
  final double width;
  final BoxFit fit;
  final Color? color;

  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
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
}
