import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/views/details/people_details/tabs/movie/components/movie_credits_thumbnail.dart';

class PeopleMovieTab extends StatelessWidget with AvatarBuilderMixin {
  // final List<MovieResultModel> movies;

  final _configurationController = Get.find<ConfigurationController>();

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
          onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
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
