import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/utility_controller.dart';

Widget toggleHideShowBtn() {
  final _utilityController = Get.find<UtilityController>();

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () {
          _utilityController.toggleHideShowBtn();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
          color: Colors.transparent,
          child: Obx(() => Text(
                _utilityController.showText != true ? 'More' : 'Less',
                style: const TextStyle(
                  color: primaryblue,
                  fontSize: n - 2,
                ),
              )),
        ),
      ),
    ],
  );
}
