import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/season_controller.dart';
import '../../components/storyline_text.dart';
import '../episode_crew/episode_crew_builder.dart';
import '../guest_casts/episode_guest_cast.dart';

class EpisodeDetailsInfo extends StatelessWidget {
  EpisodeDetailsInfo({Key? key}) : super(key: key);

  final _seasonController = Get.find<SeasonController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        StoryLineTextBuilder(
            text: _seasonController.episodeModel.value.overview ?? "overview"),
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
