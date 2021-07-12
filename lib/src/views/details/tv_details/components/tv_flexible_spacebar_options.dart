import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/account_controller.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/utils/auth.dart';
import 'package:movie_app/src/views/details/tv_details/components/tv_rating_component.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget tvFlexibleSpacebarOptions({required DetailsController controller}) {
  final _detailsController = Get.find<DetailsController>();
  final _accountController = Get.find<AccountController>();

  return GetBuilder(
    id: 'account_state',
    init: _detailsController,
    initState: (_) {
      Auth().isGuestLoggedIn == true
          ? null
          : _detailsController.getOtherDetails(
              resultType: tvString,
              id: '${_detailsController.tvDetail.value.id}',
              appendTo: accountStateString,
            );
    },
    builder: (controller) => WidgetBuilderHelper(
        state: _detailsController.accountstateState.value,
        onLoadingBuilder: LoadingSpinner().horizontalLoading,
        onSuccessBuilder: _detailsController.accountstateState.value ==
                ViewState.busy
            ? LoadingSpinner().horizontalLoading
            : Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: Auth().isGuestLoggedIn == true
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceAround,
                    children: [
                      // user score circle percent indicator
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                        child: Row(
                          children: [
                            _detailsController.tvDetail.value.voteAverage ==
                                    null
                                ? const SizedBox.shrink()
                                : CircularPercentIndicator(
                                    radius: 56,
                                    percent: (_detailsController
                                            .tvDetail.value.voteAverage! /
                                        10),
                                    curve: Curves.ease,
                                    animation: true,
                                    animationDuration: 800,
                                    progressColor: primaryblue,
                                    center: Text(
                                      '${(_detailsController.tvDetail.value.voteAverage! * 10).toInt()}%',
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
                      ),

                      // lists btn
                      // optionBtn(
                      //   onTap: () {
                      //     print(Auth().sessionId);
                      //     Get.bottomSheet(ListComponent());
                      //   },
                      //   icon: Icons.list,
                      // ),

                      //  favorite btn
                      Auth().isGuestLoggedIn == true
                          ? const SizedBox.shrink()
                          : _accountController.favoriteState.value ==
                                  ViewState.busy
                              ? LoadingSpinner().fadingCircleSpinner
                              : optionBtn(
                                  onTap: () {
                                    print(_detailsController
                                        .accountState.value.favorite);
                                    if (_detailsController
                                            .accountState.value.favorite ==
                                        false) {
                                      _accountController.postToFavorites(
                                        mediaId: _detailsController
                                            .tvDetail.value.id,
                                        mediaType: tvString,
                                        favorite: true,
                                      );
                                    } else {
                                      _accountController.postToFavorites(
                                        mediaId: _detailsController
                                            .tvDetail.value.id,
                                        mediaType: tvString,
                                        favorite: false,
                                      );
                                    }
                                  },
                                  color: _detailsController
                                              .accountState.value.favorite ==
                                          true
                                      ? const Color(0xfffc19e2)
                                      : primaryWhite,
                                  icon: Icons.favorite,
                                ),

                      // watchlist btn
                      Auth().isGuestLoggedIn == true
                          ? const SizedBox.shrink()
                          : _accountController.watchlistState.value ==
                                  ViewState.busy
                              ? LoadingSpinner().fadingCircleSpinner
                              : optionBtn(
                                  onTap: () {
                                    print(_detailsController
                                        .accountState.value.watchlist);

                                    if (_detailsController
                                            .accountState.value.watchlist ==
                                        false) {
                                      _accountController.postToWatchlist(
                                        mediaId: _detailsController
                                            .tvDetail.value.id,
                                        mediaType: tvString,
                                        watchlist: true,
                                      );
                                    } else {
                                      _accountController.postToWatchlist(
                                        mediaId: _detailsController
                                            .tvDetail.value.id,
                                        mediaType: tvString,
                                        watchlist: false,
                                      );
                                    }
                                  },
                                  color: _detailsController
                                              .accountState.value.watchlist ==
                                          true
                                      ? primaryblue
                                      : primaryWhite,
                                  icon: Icons.bookmark,
                                ),

                      // rate btn
                      Auth().isGuestLoggedIn == true
                          ? Row(children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                // height: 46,
                                // width: 46,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primaryDarkBlue.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${_detailsController.tvDetail.value.voteCount}',
                                  style: const TextStyle(
                                    fontSize: l - 2,
                                    color: primaryWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Vote\nCounts',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: n - 2,
                                  fontWeight: FontWeight.w700,
                                  color: primaryDarkBlue,
                                ),
                              ),
                            ])
                          : _detailsController.rateState.value == ViewState.busy
                              ? LoadingSpinner().fadingCircleSpinner
                              : optionBtn(
                                  onTap: () {
                                    print(_detailsController.tvDetail.value.id);
                                    // initialization on rate value in controller

                                    print(_detailsController
                                        .accountState.value.rated);

                                    _detailsController
                                                .accountState.value.rated ==
                                            false
                                        ? _detailsController.setRateValue(0.5)
                                        : _detailsController.setRateValue(
                                            _detailsController.accountState
                                                .value.rated['value']);
                                    Get.bottomSheet(
                                      TvRatingComponent(
                                        rating: _detailsController
                                                    .accountState.value.rated ==
                                                false
                                            ? 0.5
                                            : _detailsController.accountState
                                                .value.rated['value'],
                                      ),
                                    );
                                  },
                                  color: _detailsController
                                              .accountState.value.rated ==
                                          false
                                      ? primaryWhite
                                      : Colors.amber.shade400,
                                  icon: Icons.star,
                                ),
                    ],
                  ),
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
          size: 20,
          color: color ?? primaryWhite,
        ),
      ],
    ),
  );
}
