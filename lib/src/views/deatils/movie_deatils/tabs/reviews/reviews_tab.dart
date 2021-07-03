import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/views/deatils/components/review_builder.dart';

class MovieReviewTab extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();

  MovieReviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_reviews',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: movieString,
            id: _resultsController.movieId,
            appendTo: reviewsString);
      },
      builder: (controller) => WidgetBuilderHelper(
        state: _detailsController.reviewsState.value,
        onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
        onErrorBuilder: const Center(
          child: Text('error whlie loading data ...'),
        ),
        onSuccessBuilder: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Text(
                '${_detailsController.reviews.value.results == null ? 0 : _detailsController.reviews.value.results!.length} Reviews',
                style: TextStyle(
                  color: primaryDarkBlue.withOpacity(0.7),
                  fontSize: n,
                ),
              ),
            ),
            ListView.separated(
              itemCount: _detailsController.reviews.value.results == null
                  ? 0
                  : _detailsController.reviews.value.results!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                ReviewsResult review =
                    _detailsController.reviews.value.results![index];

                return ReviewBuilder(
                  key: UniqueKey(),
                  review: review,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
