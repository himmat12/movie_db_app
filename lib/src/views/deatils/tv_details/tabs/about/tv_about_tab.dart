import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/views/deatils/components/crew_component.dart';
import 'package:movie_app/src/views/deatils/components/genre_component.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';

import 'package:movie_app/src/views/deatils/components/storyline_text.dart';

import 'package:movie_app/src/views/deatils/tv_details/tabs/about/components/networks.dart';

import 'components/tv_info.dart';

class TvAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();
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
            resultType: TV_STRING,
            id: _resultsController.tv.id!,
            appendTo: IMAGES_STRING);
      },
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            storylineTextBuilder(
                text:
                    _detailsController.tvDetail.value.overview ?? "storyline"),
            toggleHideShowBtn(),
            const SizedBox(height: 12),
            genreBuilder(
                genres: _detailsController.tvDetail.value.genres ?? []),
            const SizedBox(height: 18),
            networkBuilder(
                networks: _detailsController.tvDetail.value.networks ?? []),
            const SizedBox(height: 18),
            crewBuilder(crews: _detailsController.credits.value.crew ?? []),
            const SizedBox(height: 18),
            tvInfoBuilder(tvDetails: _detailsController.tvDetail.value),
          ],
        ),
        // ),
      ),
    );
  }
}
