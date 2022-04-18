import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/utility_controller.dart';
import 'header_text.dart';
import 'hide_show_btn.dart';

class StoryLineTextBuilder extends GetView<UtilityController> {
  const StoryLineTextBuilder({
    required this.text,
    this.maxLines,
    this.headerText,
    Key? key,
  }) : super(key: key);

  final String text;
  final int? maxLines;
  final String? headerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerBuilder(headerText: headerText ?? "Story Line"),
        const SizedBox(height: 8),
        text == ""
            ? Text(
                'No data at the Moment',
                style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
              )
            : Obx(
                () => controller.showText.value != true
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
              ),
        text == "" ? const SizedBox.shrink() : toggleHideShowBtn(),
      ],
    );
  }
}
