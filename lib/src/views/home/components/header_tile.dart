import 'package:flutter/material.dart';

import '../../../configs/configs.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile(
      {this.onMoreTap, this.subtitle, this.title, this.toggleOption, Key? key})
      : super(key: key);

  final String? title;
  final String? subtitle;
  final void Function()? onMoreTap;
  final Widget? toggleOption;

  @override
  Widget build(BuildContext context) {
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
}
