import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/strings.dart';
import '../../../../../controllers/configuration_controller.dart';
import '../../../../../controllers/details_controller.dart';
import '../../../../../controllers/results_controller.dart';
import '../../../../../global/loading_spinner.dart';
import '../../../../../helpers/widget_builder_helper.dart';
import '../../../../../models/details/tv_details_model.dart';
import '../../../components/crew_component.dart';
import '../../../components/genre_component.dart';
import '../../../components/header_text.dart';
import '../../../components/media_component.dart';
import '../../../components/storyline_text.dart';
import '../../../components/trailer_component.dart';
import '../../components/episode_tile.dart';
import 'components/networks.dart';
import 'components/tv_info.dart';

class TvAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();
  final _configurationController = Get.find<ConfigurationController>();

  TvAboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // EpisodeToAir? episode = _detailsController.tvDetail.value.lastEpisodeToAir;
    // final String? airDate =
    //     DateFormat.yMMMMd().format(episode!.airDate ?? DateTime(0000));

    return
        //  Obx(
        //   () =>
        GetBuilder(
      id: 'tv_about',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: tvString,
            id: _resultsController.tvId,
            appendTo: imagesString);
      },
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StoryLineTextBuilder(
                text: _detailsController.tvDetail.value.overview ??
                    "no storyline at the moment"),
          ),
          const SizedBox(height: 12),

          // genres
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GenreBuilder(
                genres: _detailsController.tvDetail.value.genres ?? []),
          ),
          const SizedBox(height: 18),
          // networks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: NetworkBuilder(
                networks: _detailsController.tvDetail.value.networks ?? []),
          ),
          const SizedBox(height: 18),

          // last & next episodes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: HeaderBuilder(headerText: "Episodes"),
              ),
              const SizedBox(height: 14),
              _detailsController.tvDetail.value.lastEpisodeToAir == null
                  ? const SizedBox.shrink()
                  : EpisodeTile(
                      headerText: 'Last Episode',
                      episode:
                          _detailsController.tvDetail.value.lastEpisodeToAir ??
                              EpisodeToAir()),
              const SizedBox(height: 8),
              _detailsController.tvDetail.value.nextEpisodeToAir == null
                  ? const SizedBox.shrink()
                  : EpisodeTile(
                      headerText: 'Next Episode',
                      episode:
                          _detailsController.tvDetail.value.nextEpisodeToAir ??
                              EpisodeToAir()),
            ],
          ),
          const SizedBox(height: 18),

          // featured crews
          GetBuilder(
            id: 'tv_crews',
            init: _detailsController,
            initState: (_) {
              _detailsController.getOtherDetails(
                  resultType: tvString,
                  id: _resultsController.tvId,
                  appendTo: creditsString);
            },
            builder: (controller) => WidgetBuilderHelper(
              state: _detailsController.creditsState.value,
              onLoadingBuilder: LoadingSpinner().horizontalLoading,
              onSuccessBuilder: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CrewBuilder(
                  resultType: tvString,
                  crews: _detailsController.credits.value.crew ?? [],
                ),
              ),
              onErrorBuilder: const Center(
                child: Text('error while loading data ...'),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // tv info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TvInfoBuilder(tvDetails: _detailsController.tvDetail.value),
          ),
          const SizedBox(height: 28),

          /// teasers & trailers
          GetBuilder(
            id: 'video_state',
            init: _detailsController,
            initState: (_) {
              _detailsController.getOtherDetails(
                  resultType: tvString,
                  id: _resultsController.tvId,
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
          const SizedBox(height: 28),

          /// media
          GetBuilder(
            id: 'tv_media',
            init: _detailsController,
            initState: (state) {
              _detailsController.getOtherDetails(
                  resultType: tvString,
                  id: _resultsController.tvId,
                  appendTo: imagesString);
            },
            builder: (controller) => WidgetBuilderHelper(
              state: _detailsController.imagesState.value,
              onLoadingBuilder: LoadingSpinner().horizontalLoading,
              onSuccessBuilder: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MediaComponent(
                  posterUrl:
                      '${_configurationController.posterUrl}${_detailsController.tvDetail.value.posterPath}',
                  backdropUrl:
                      '${_configurationController.backDropUrl}${_detailsController.tvDetail.value.backdropPath}',
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
    );
  }
}
