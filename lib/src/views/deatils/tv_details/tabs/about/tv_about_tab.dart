import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/components/crew_component.dart';
import 'package:movie_app/src/views/deatils/components/genre_component.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';
import 'package:movie_app/src/views/deatils/components/storyline_text.dart';
import 'package:movie_app/src/views/deatils/components/trailer_component.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/about/components/networks.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/about/components/tv_info.dart';

class TvAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();

  TvAboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                storylineTextBuilder(
                    text: _detailsController.tvDetail.value.overview ??
                        "storyline"),
                toggleHideShowBtn(),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // genres
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: genreBuilder(
                genres: _detailsController.tvDetail.value.genres ?? []),
          ),
          const SizedBox(height: 18),

          // networks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: networkBuilder(
                networks: _detailsController.tvDetail.value.networks ?? []),
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
                child: crewBuilder(
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
            child: tvInfoBuilder(tvDetails: _detailsController.tvDetail.value),
          ),
        ],
      ),
    );
  }
}
