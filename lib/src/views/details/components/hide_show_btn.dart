import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/utility_controller.dart';

class ToggleHideShowBtn extends GetView<UtilityController> {
  const ToggleHideShowBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            controller.toggleHideShowBtn();
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
            color: Colors.transparent,
            child: Obx(() => Text(
                  controller.showText.value != true ? 'More' : 'Less',
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
}
