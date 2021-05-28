import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global_components/horizontal_bloc_skeleton.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/models/api_configuration_model.dart';
import 'package:movie_app/src/views/home/components/movies_bloc_builder.dart';
import 'package:movie_app/src/views/home/components/tv_bloc_builder.dart';
import 'components/app_bar.dart';

class HomePage extends StatelessWidget {
  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBarBuilder(),
        Column(
          children: [
            moviesBlockBuilder(
              onMoreTap: () {},
              posterUrl: _configurationController.posterUrl,
              title: 'Movies',
            ),
            const SizedBox(height: 22),
            tvBlockBuilder(
                onMoreTap: () {},
                posterUrl: _configurationController.posterUrl,
                title: 'TV Series'),
            TextButton(
              onPressed: () {
                _trendingResultsController.getTrendingMovieResults(
                    timeWindow: WEEK_STRING);
                // _resultsController.getMovieResults(
                //     resultType: NOW_PLAYING_STRING);
                // _resultsController.getTvResults(
                //     resultType: ON_THE_AIR_STRING);
              },
              child: const Text('get service results'),
            ),
          ],
        ),
      ],
    );
  }
}
