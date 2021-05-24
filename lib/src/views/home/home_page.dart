import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'components/app_bar.dart';
import 'components/img_slider.dart';

class HomePage extends StatelessWidget {
  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBarBuilder(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              imgSliderBuilder(),
            ],
          ),
        ),
      ],
    );
  }
}
