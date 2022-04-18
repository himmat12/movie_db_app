import 'package:flutter/material.dart';

import '../../../configs/configs.dart';

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
        IconButton(
            onPressed: onMoreTap,
            icon: Icon(
              Icons.arrow_forward,
              color: primaryDarkBlue.withOpacity(0.8),
            )),
      ],
    ),
  );
}
