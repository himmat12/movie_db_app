import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../configs/configs.dart';
import '../../../../models/peoples/people_model.dart';

Widget peopleFlexibleSpacebarOptions({required PeopleModel people}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Row(
      children: [
        people.popularity == null
            ? const SizedBox.shrink()
            : CircularPercentIndicator(
                radius: 56,
                percent: (people.popularity ?? 0.0).toInt() / 100,
                curve: Curves.ease,
                animation: true,
                animationDuration: 800,
                progressColor: primaryblue,
                center: Text(
                  '${((people.popularity ?? 0.0).toInt())}%',
                  style: const TextStyle(
                    color: primaryDarkBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
        const SizedBox(width: 4),
        const Text(
          'User\nScore',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: n - 2,
            fontWeight: FontWeight.w700,
            color: primaryDarkBlue,
          ),
        ),
      ],
    ),
  );
}

// helpers
Widget optionBtn({IconData? icon, void Function()? onTap, Color? color}) {
  return GestureDetector(
    onTap: onTap ?? () {},
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: primaryDarkBlue.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
        ),
        Icon(
          icon ?? Icons.list,
          color: color ?? primaryWhite,
        ),
      ],
    ),
  );
}
