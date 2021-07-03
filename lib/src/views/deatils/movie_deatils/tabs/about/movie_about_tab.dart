import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/components/crew_component.dart';
import 'package:movie_app/src/views/deatils/components/genre_component.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';
import 'package:movie_app/src/views/deatils/components/storyline_text.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/about/components/movie_info.dart';

class MovieAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();

  MovieAboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_about',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: movieString,
            id: _resultsController.movieId,
            appendTo: imagesString);
      },
      builder: (controller) => WidgetBuilderHelper(
        state: _detailsController.movieDetailState.value,
        onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
        onErrorBuilder: const Center(
          child: Text('error while loading data ...'),
        ),
        onSuccessBuilder: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              storylineTextBuilder(
                  text: _detailsController.movieDetail.value.overview ??
                      "storyline"),
              toggleHideShowBtn(),
              const SizedBox(height: 12),
              genreBuilder(
                  genres: _detailsController.movieDetail.value.genres ?? []),
              const SizedBox(height: 18),
              GetBuilder(
                id: 'movie_crews',
                init: _detailsController,
                initState: (_) {
                  _detailsController.getOtherDetails(
                      resultType: movieString,
                      id: _resultsController.movieId,
                      appendTo: creditsString);
                },
                builder: (controller) => WidgetBuilderHelper(
                  state: _detailsController.creditsState.value,
                  onLoadingBuilder: LoadingSpinner().horizontalLoading,
                  onSuccessBuilder: crewBuilder(
                    resultType: movieString,
                    crews: _detailsController.credits.value.crew ?? [],
                  ),
                  onErrorBuilder: const Center(
                    child: Text('error while loading data ...'),
                  ),
                  // )
                ),
              ),
              const SizedBox(height: 18),
              movieInfoBuilder(
                  movieDetails: _detailsController.movieDetail.value),
            ],
          ),
        ),
      ),
    );
  }
}
