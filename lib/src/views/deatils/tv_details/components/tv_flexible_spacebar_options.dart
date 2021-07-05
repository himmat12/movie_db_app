import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget tvFlexibleSpacebarOptions({required DetailsController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // user score circle percent indicator
        Row(
          children: [
            controller.tvDetail.value.voteAverage == null
                ? const SizedBox.shrink()
                : CircularPercentIndicator(
                    radius: 56,
                    percent: (controller.tvDetail.value.voteAverage! / 10),
                    curve: Curves.ease,
                    animation: true,
                    animationDuration: 800,
                    progressColor: primaryblue,
                    center: Text(
                      '${(controller.tvDetail.value.voteAverage! * 10).toInt()}%',
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

        // lists/ favourite / bookmarks /rate options
        optionBtn(
          onTap: () {},
          icon: Icons.list,
        ),
        optionBtn(
          onTap: () {},
          // color: _detailsController.movieDetail.value.accountStates!.favorite ==
          //         false
          //     ? primaryWhite
          //     : const Color(0xfffc19e2).withOpacity(0.9),
          icon: Icons.favorite,
        ),
        optionBtn(
          onTap: () {},
          // color:
          //     _detailsController.movieDetail.value.accountStates!.watchlist ==
          //             false
          //         ? primaryWhite
          //         : primaryblue,
          icon: Icons.bookmark,
        ),
        optionBtn(
          onTap: () {},
          // color:
          //     _detailsController.movieDetail.value.accountStates!.rated == false
          //         ? primaryWhite
          //         : Colors.amber.shade600,
          icon: Icons.star,
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
