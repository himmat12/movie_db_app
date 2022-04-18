import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/views/details/components/genre_component.dart';
import 'package:movie_app/src/views/details/components/storyline_text.dart';
import 'package:movie_app/src/views/details/tv_details/tabs/about/components/networks.dart';

class SeasonAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();

  final _seasonController = Get.find<SeasonController>();

  SeasonAboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          StoryLineTextBuilder(
              text:
                  _seasonController.seasonModel.value.overview ?? "storyline"),
          const SizedBox(height: 12),
          genreBuilder(genres: _detailsController.tvDetail.value.genres ?? []),
          const SizedBox(height: 18),
          networkBuilder(
              networks: _detailsController.tvDetail.value.networks ?? []),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
