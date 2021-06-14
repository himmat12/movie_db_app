import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/movie%20_list/movie_list.dart';

import 'components/movie_credits_thumbnail.dart';

class PeopleMovieTab extends StatelessWidget with AvatarBuilderMixin {
  // final List<MovieResultModel> movies;

  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();

  final _utilityController = Get.find<UtilityController>();
  final _peopleController = Get.find<PeopleController>();

  PeopleMovieTab({
    Key? key,
    // required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'people_movies',
      init: _peopleController,
      initState: (_) {
        _peopleController.getCreditsDetails(
            personId: _peopleController.personId,
            resultType: movieCreditsString);
      },
      builder: (controller) {
        return WidgetBuilderHelper(
          state: _peopleController.movieCreditsState.value,
          onLoadingBuilder: LoadingSpinner.fadingCircleSpinner,
          onErrorBuilder: const Center(
            child: Text('error while loading data ...'),
          ),
          onSuccessBuilder: _peopleController.movieCredits.value.cast == null ||
                  _peopleController.movieCredits.value.cast!.isEmpty
              ? SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      'No Movies Credits at the Moment',
                      style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                    ),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 28),
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          _peopleController.movieCredits.value.cast!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 186,
                      ),
                      itemBuilder: (context, index) =>
                          movieCreditsThumbnailCard(
                        padding: const EdgeInsets.all(0),
                        movie:
                            _peopleController.movieCredits.value.cast![index],
                        imageUrl:
                            '${_configurationController.posterUrl}${_peopleController.movieCredits.value.cast![index].posterPath}',
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
