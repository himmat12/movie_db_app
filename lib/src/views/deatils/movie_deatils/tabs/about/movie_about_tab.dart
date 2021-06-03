import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/views/deatils/components/crew_component.dart';
import 'package:movie_app/src/views/deatils/components/genre_component.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';

import 'package:movie_app/src/views/deatils/movie_deatils/components/storyline_text.dart';

import 'package:movie_app/src/views/deatils/movie_deatils/tabs/about/components/movie_info.dart';

class MovieAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();

  MovieAboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            storylineTextBuilder(
                text: _detailsController.movieDetail.value.overview ??
                    "storyline"),
            toggleHideShowBtn(),
            const SizedBox(height: 12),
            genreBuilder(
                genres: _detailsController.movieDetail.value.genres ?? []),
            const SizedBox(height: 18),
            crewBuilder(
                crews:
                    _detailsController.movieDetail.value.credits!.crew ?? []),
            const SizedBox(height: 18),
            movieInfoBuilder(
                movieDetails: _detailsController.movieDetail.value),
          ],
        ),
      ),
    );
  }
}
