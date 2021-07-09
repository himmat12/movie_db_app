import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/details/components/crew_component.dart';
import 'package:movie_app/src/views/details/components/genre_component.dart';
import 'package:movie_app/src/views/details/components/hide_show_btn.dart';
import 'package:movie_app/src/views/details/components/media_component.dart';
import 'package:movie_app/src/views/details/components/storyline_text.dart';
import 'package:movie_app/src/views/details/components/trailer_component.dart';
import 'package:movie_app/src/views/details/movie_deatils/tabs/about/components/belongs_to_collection.dart';
import 'package:movie_app/src/views/details/movie_deatils/tabs/about/components/movie_info.dart';

class MovieAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();
  final _configurationController = Get.find<ConfigurationController>();

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
        onSuccessBuilder: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),

            ///story line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  storylineTextBuilder(
                      text: _detailsController.movieDetail.value.overview ??
                          "storyline"),
                  toggleHideShowBtn(),
                ],
              ),
            ),
            const SizedBox(height: 12),

            /// genre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: genreBuilder(
                  genres: _detailsController.movieDetail.value.genres ?? []),
            ),
            const SizedBox(height: 28),

            /// teasers & trailers
            GetBuilder(
              id: 'video_state',
              init: _detailsController,
              initState: (_) {
                _detailsController.getOtherDetails(
                    resultType: movieString,
                    id: _resultsController.movieId,
                    appendTo: videosString);
              },
              builder: (controller) {
                return WidgetBuilderHelper(
                  state: _detailsController.videosState.value,
                  onLoadingBuilder: LoadingSpinner().horizontalLoading,
                  onSuccessBuilder:
                      TrailerComponent(videos: _detailsController.videos.value),
                  onErrorBuilder: const Center(
                    child: Text('error occured while loading data ...'),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),

            ///featured crews
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
                onSuccessBuilder: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: crewBuilder(
                    resultType: movieString,
                    crews: _detailsController.credits.value.crew ?? [],
                  ),
                ),
                onErrorBuilder: const Center(
                  child: Text('error while loading data ...'),
                ),
                // )
              ),
            ),
            const SizedBox(height: 18),

            ///movie info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: movieInfoBuilder(
                  movieDetails: _detailsController.movieDetail.value),
            ),
            const SizedBox(height: 24),

            ///belongs to collections
            _detailsController.movieDetail.value.belongsToCollection == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MovieCollection(
                        collection: _detailsController
                            .movieDetail.value.belongsToCollection),
                  ),
            const SizedBox(height: 28),

            /// media
            GetBuilder(
              id: 'movie_media',
              init: _detailsController,
              initState: (state) {
                _detailsController.getOtherDetails(
                    resultType: movieString,
                    id: _resultsController.movieId,
                    appendTo: imagesString);
              },
              builder: (controller) => WidgetBuilderHelper(
                state: _detailsController.imagesState.value,
                onLoadingBuilder: LoadingSpinner().horizontalLoading,
                onSuccessBuilder: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MediaComponent(
                    posterUrl:
                        '${_configurationController.posterUrl}${_detailsController.movieDetail.value.posterPath}',
                    backdropUrl:
                        '${_configurationController.backDropUrl}${_detailsController.movieDetail.value.backdropPath}',
                    posterTitle:
                        '${_detailsController.images.value.posters == null ? 0 : _detailsController.images.value.posters!.length}\nPosters',
                    backdropTitle:
                        '${_detailsController.images.value.backdrops == null ? 0 : _detailsController.images.value.backdrops!.length}  Backdrops',
                  ),
                ),
                onErrorBuilder: const Center(
                  child: Text('error while loadong data ...'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
