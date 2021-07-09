import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/views/details/components/hide_show_btn.dart';
import 'package:movie_app/src/views/details/components/storyline_text.dart';
import 'package:movie_app/src/views/details/episode_details/episode_crew/episode_crew_builder.dart';
import 'package:movie_app/src/views/details/episode_details/guest_casts/episode_guest_cast.dart';

class EpisodeDetailsInfo extends StatelessWidget {
  EpisodeDetailsInfo({Key? key}) : super(key: key);

  final _seasonController = Get.find<SeasonController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
