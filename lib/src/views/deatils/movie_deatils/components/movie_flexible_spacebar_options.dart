import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/utils/auth.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/components/rating_component.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget movieFlexibleSpacebarOptions() {
  final _detailsController = Get.find<DetailsController>();

  return GetBuilder(
    id: 'account_state',
    init: _detailsController,
    initState: (_) {
      _detailsController.getOtherDetails(
        resultType: movieString,
        id: '${_detailsController.movieDetail.value.id}',
        appendTo: accountStateString,
      );
    },
    builder: (controller) => WidgetBuilderHelper(
        state: _detailsController.accountstateState.value,
        onLoadingBuilder: LoadingSpinner().horizontalLoading,
        onSuccessBuilder: _detailsController.accountstateState.value ==
                ViewState.busy
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
                          : _detailsController.accountState.value.favorite ==
                                  true
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
                          : _detailsController.accountState.value.watchlist ==
                                  true
                              ? primaryblue
                              : primaryWhite,
                      icon: Icons.bookmark,
                    ),

                    Obx(
                      () => _detailsController.rateState.value == ViewState.busy
                          ? LoadingSpinner().fadingCircleSpinner
                          : optionBtn(
                              onTap: () {
                                print(_detailsController.movieDetail.value.id);
                                // initialization on rate value in controller

                                print(_detailsController
                                    .accountState.value.rated['value']);

                                _detailsController.accountState.value.rated ==
                                        false
                                    ? _detailsController.setRateValue(0.0)
                                    : _detailsController.setRateValue(
                                        _detailsController
                                            .accountState.value.rated['value']);
                                Get.bottomSheet(
                                  RatingComponent(
                                    rating: _detailsController
                                                .accountState.value.rated ==
                                            false
                                        ? 0.0
                                        : _detailsController
                                            .accountState.value.rated['value'],
                                  ),
                                );

                                // if (_detailsController.isRated.value == false) {
                                //   _detailsController.rate(
                                //     value: 8,
                                //     mediaId:
                                //         _detailsController.movieDetail.value.id,
                                //     mediaType: movieString,
                                //     appendTo: accountStateString,
                                //   );
                                // } else {
                                //   _detailsController.deleteRating(
                                //     mediaId:
                                //         _detailsController.movieDetail.value.id,
                                //     mediaType: movieString,
                                //   );
                                // }
                              },
                              color:
                                  _detailsController.accountState.value.rated ==
                                          false
                                      ? primaryWhite
                                      : Colors.amber.shade400,
                              icon: Icons.star,
                            ),
                    ),
                  ],
                ),
              ),
        onErrorBuilder: const Center(
          child: Text('error while loading data ...'),
        )),
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
