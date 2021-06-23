import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';
import 'package:movie_app/src/views/deatils/components/storyline_text.dart';
import 'package:movie_app/src/views/deatils/episode_details/episode_crew/episode_crew_builder.dart';
import 'package:movie_app/src/views/deatils/episode_details/guest_stars/episode_guest_cast.dart';

class EpisodeDetailsInfo extends StatelessWidget {
  EpisodeDetailsInfo({Key? key}) : super(key: key);

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _seasonController = Get.find<SeasonController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        storylineTextBuilder(
            text: _seasonController.episodeModel.value.overview ?? "overview"),
        toggleHideShowBtn(),
        const SizedBox(height: 18),
        GuestCasts(),
        const SizedBox(height: 18),
        episodeCrewBuilder(
            crews: _seasonController.episodeModel.value.crew ?? []),
        const SizedBox(height: 18),
      ],
    );
  }
}
