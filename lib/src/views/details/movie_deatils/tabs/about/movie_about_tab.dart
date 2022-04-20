import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/strings.dart';
import '../../../../../controllers/configuration_controller.dart';
import '../../../../../controllers/details_controller.dart';
import '../../../../../controllers/results_controller.dart';
import '../../../../../global/loading_spinner.dart';
import '../../../../../helpers/widget_builder_helper.dart';
import '../../../components/crew_component.dart';
import '../../../components/genre_component.dart';
import '../../../components/media_component.dart';
import '../../../components/storyline_text.dart';
import '../../../components/trailer_component.dart';
import 'components/belongs_to_collection.dart';
import 'components/movie_info.dart';

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
              child: StoryLineTextBuilder(
                  text: _detailsController.movieDetail.value.overview ??
                      "No data at the moment"),
            ),
            const SizedBox(height: 12),

            /// genre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GenreBuilder(
                  genres: _detailsController.movieDetail.value.genres ?? []),
            ),
            const SizedBox(height: 28),

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
                  child: CrewBuilder(
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
              child: MovieInfoBuilder(
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
