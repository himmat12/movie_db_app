import 'package:flutter/material.dart';

import '../configs/configs.dart';

mixin AvatarBuilderMixin {
  Widget avatarBuilder({double? height, double? width}) => Container(
        height: height ?? 68,
        width: width ?? 68,
        color: primaryDarkBlue.withOpacity(0.4),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned(
              bottom: -26,
              child: Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryDarkBlue.withOpacity(0.4)),
                  color: Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryDarkBlue.withOpacity(0.4)),
                  color: Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      );
}
