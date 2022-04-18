import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/details_controller.dart';
import '../../../../../controllers/season_controller.dart';
import '../../../components/genre_component.dart';
import '../../../components/storyline_text.dart';
import '../../../tv_details/tabs/about/components/networks.dart';

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
