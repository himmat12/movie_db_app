import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/global_components/switch_btn.dart';

Widget widgetsBlockBuilder({
  String? title,
}) {
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            Text(
              title ?? 'Trending',
              style: const TextStyle(fontSize: m),
            ),
            const SizedBox(width: 12),
            switchBtnBuilder(
              text1: "On TV",
              text2: "On Theatures",
            ),
          ],
        ),
      ],
    ),
  );
}
