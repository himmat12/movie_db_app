import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/views/deatils/components/header_text.dart';

Widget storylineTextBuilder({required String text, int? maxLines}) {
  final _utilityController = Get.find<UtilityController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Story Line"),
      const SizedBox(height: 8),
      _utilityController.showText != true
          ? Text(
              text,
              maxLines: maxLines ?? 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: primaryDarkBlue.withOpacity(0.6),
                fontSize: n - 2,
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: primaryDarkBlue.withOpacity(0.6),
                fontSize: n - 2,
              ),
            ),
    ],
  );
}
