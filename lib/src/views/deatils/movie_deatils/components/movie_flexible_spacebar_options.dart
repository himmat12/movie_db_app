import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/utils/auth.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget movieFlexibleSpacebarOptions() {
  final _detailsController = Get.find<DetailsController>();

  /// rate field in api schema contains (bool or object) value so inorder to seperate the business logic for color incicators in rate btn we apply this method
  Color getRatedColor({required AccountStates accountStates}) {
    Color color = primaryWhite;
    if (accountStates.isBlank != true) {
      if (accountStates.rated != false) {
        if (accountStates.rated['value'] != null ||
            accountStates.rated['value'].isBlank == true) {
          color = Colors.amber.shade600;
        }
      }
    }
    return color;
  }

  return Obx(
    () => _detailsController.accountstateState.value == ViewState.busy
        ? LoadingSpinner().horizontalLoading
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // user score circle percent indicator
                Row(
                  children: [
                    _detailsController.movieDetail.value.voteAverage == null
                        ? const SizedBox.shrink()
                        : CircularPercentIndicator(
                            radius: 56,
                            percent: (_detailsController
                                    .movieDetail.value.voteAverage! /
                                10),
                            curve: Curves.ease,
                            animation: true,
                            animationDuration: 800,
                            progressColor: primaryblue,
                            center: Text(
                              '${(_detailsController.movieDetail.value.voteAverage! * 10).toInt()}%',
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
                  onTap: () {
                    print(Auth().sessionId);
                  },
                  icon: Icons.list,
                ),
                optionBtn(
                  onTap: () {
                    print(_detailsController.accountState.value.favorite);
                  },
                  color: _detailsController.accountState.isBlank == true
                      ? primaryWhite
                      : _detailsController.accountState.value.favorite == true
                          ? const Color(0xfffc19e2).withOpacity(0.9)
                          : primaryWhite,
                  icon: Icons.favorite,
                ),

                optionBtn(
                  onTap: () {
                    print(_detailsController.accountState.value.watchlist);
                  },
                  color: _detailsController.accountState.isBlank == true
                      ? primaryWhite
                      : _detailsController.accountState.value.watchlist == true
                          ? primaryblue
                          : primaryWhite,
                  icon: Icons.bookmark,
                ),
                Obx(
                  () => optionBtn(
                    onTap: () {
                      _detailsController.rate(
                        value: 8,
                        mediaId: _detailsController.movieDetail.value.id,
                        mediaType: movieString,
                      );

                      // print(_detailsController.accountState.value.rated['value']);
                    },
                    color: getRatedColor(
                        accountStates: _detailsController.accountState.value),
                    icon: Icons.star,
                  ),
                ),
              ],
            ),
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
