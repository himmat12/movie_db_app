import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RatingComponent extends StatelessWidget {
  RatingComponent({
    required this.rating,
    Key? key,
  }) : super(key: key);

  final double rating;

  final _detailsController = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    evaluateRateQuote(_detailsController.rateValue.value);
    print('HASH CODE: $hashCode');

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 1,
        minChildSize: 0.3,
        expand: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: const BoxDecoration(
                color: primaryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Obx(
                () => Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    SizedBox(
                      height: 360,
                      child: Column(
                        children: [
                          const SizedBox(height: 44),
                          // percentage indicator
                          CircularPercentIndicator(
                            radius: 80,
                            percent: (_detailsController.rateValue.value / 10),
                            curve: Curves.ease,
                            animation: true,
                            animationDuration: 800,
                            progressColor: primaryblue,
                            lineWidth: 8,
                            animateFromLastPercent: true,
                            center: Text(
                              '${(_detailsController.rateValue.value * 10).toInt()}%',
                              style: const TextStyle(
                                color: primaryDarkBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // rating bar
                          AbsorbPointer(
                            absorbing: _detailsController.rateState.value ==
                                    ViewState.busy
                                ? true
                                : false,
                            child: RatingBar(
                              onRatingUpdate: (value) {
                                _detailsController.setRateValue(value);
                                print(_detailsController.rateValue.value);
                                evaluateRateQuote(value);
                              },
                              ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: primaryDarkBlue05,
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: primaryDarkBlue05,
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    color: primaryDarkBlue05,
                                  )),
                              itemCount: 10,
                              allowHalfRating: true,
                              initialRating: rating,
                              maxRating: 10,
                              minRating: 0.5,
                              updateOnDrag: true,
                              itemSize: 34,
                              wrapAlignment: WrapAlignment.center,
                              glow: false,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // rating quotes
                          ratingQuotes(_detailsController.rateQuote.value),

                          const SizedBox(height: 18),

                          // rate actions
                          AbsorbPointer(
                            absorbing: _detailsController.rateState.value ==
                                    ViewState.busy
                                ? true
                                : false,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _detailsController.deleteRating(
                                        mediaId: _detailsController
                                            .movieDetail.value.id,
                                        mediaType: movieString,
                                      );
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              primaryblue05),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryDarkBlue),
                                    ),
                                    child: const Text('Remove'),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () {
                                      _detailsController.rate(
                                        rateValue:
                                            _detailsController.rateValue.value,
                                        mediaId: _detailsController
                                            .movieDetail.value.id,
                                        mediaType: movieString,
                                        appendTo: accountStateString,
                                      );
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              primaryWhite),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryblue),
                                    ),
                                    child: const Text('Apply'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // loading state spinner
                    _detailsController.rateState.value == ViewState.busy
                        ? Positioned(
                            top: 6,
                            child: LoadingSpinner().horizontalLoading,
                          )
                        : const SizedBox.shrink(),

                    // exit btn
                    Positioned(
                      top: 12,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryDarkBlue05,
                          ),
                          child: const Icon(
                            Icons.clear,
                            color: primaryWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget ratingQuotes(String quote) {
    switch (quote) {
      case terribleString:
        return textBuilder(terribleString);
      case poorString:
        return textBuilder(poorString);
      case notBadString:
        return textBuilder(notBadString);
      case okayString:
        return textBuilder(okayString);
      case goodString:
        return textBuilder(goodString);
      case greatString:
        return textBuilder(greatString);
      case wonderfulString:
        return textBuilder(wonderfulString);
      default:
        break;
    }
    return textBuilder(rateQuestionString);
  }

  Widget textBuilder(text) => Text(
        text,
        style: const TextStyle(
          fontSize: l,
          fontWeight: FontWeight.w500,
          color: primaryDarkBlue05,
        ),
      );

  void evaluateRateQuote(value) {
    if (value > 0.5 && value <= 1.5) {
      _detailsController.setRateQuote(terribleString);
    } else if (value > 1.5 && value <= 3) {
      _detailsController.setRateQuote(poorString);
    } else if (value > 3 && value <= 4) {
      _detailsController.setRateQuote(notBadString);
    } else if (value > 4 && value <= 5.5) {
      _detailsController.setRateQuote(okayString);
    } else if (value > 5.5 && value <= 6.5) {
      _detailsController.setRateQuote(goodString);
    } else if (value > 6.5 && value <= 8.5) {
      _detailsController.setRateQuote(greatString);
    } else if (value > 8.5 && value <= 10) {
      _detailsController.setRateQuote(wonderfulString);
    } else {
      _detailsController.setRateQuote(rateQuestionString);
    }
  }
}
