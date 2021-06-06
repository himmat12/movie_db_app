import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';

import 'components/review_builder.dart';

class MovieReviewTab extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();

  MovieReviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Text(
            '${_detailsController.movieDetail.value.reviews!.results!.length} Reviews',
            style: TextStyle(
              color: primaryDarkBlue.withOpacity(0.7),
              fontSize: n,
            ),
          ),
        ),
        ListView.separated(
          itemCount:
              _detailsController.movieDetail.value.reviews!.results!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            ReviewsResult review =
                _detailsController.movieDetail.value.reviews!.results![index];

            return ReviewBuilder(
              key: UniqueKey(),
              review: review,
            );
          },
        ),
      ],
    );
  }
}
