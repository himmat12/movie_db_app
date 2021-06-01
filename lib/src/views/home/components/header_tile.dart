import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/global/more_btn.dart';
import 'package:movie_app/src/global/switch_btn.dart';

Widget headerTile({
  String? title,
  String? subtitle,
  void Function()? onMoreTap,
  Widget? toggleOption,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title ?? 'title',
              style: const TextStyle(fontSize: m - 2),
            ),
            const SizedBox(width: 4),
            Text(
              subtitle ?? 'subtitle',
              style: const TextStyle(
                fontSize: m - 4,
                color: primaryblue,
              ),
            ),
            const SizedBox(width: 6),
            toggleOption ?? const SizedBox.shrink(),
          ],
        ),
        GestureDetector(
          onTap: onMoreTap ?? () {},
          child: Container(
            color: Colors.transparent,
            child: const Text('More'),
          ),
        ),
      ],
    ),
  );
}
