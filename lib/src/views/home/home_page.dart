import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global_components/switch_btn.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/models/api_configuration_model.dart';
import 'package:movie_app/src/views/home/components/movies_results_builder.dart';
import 'package:movie_app/src/views/home/components/trending_movies_builder.dart';
import 'package:movie_app/src/views/home/components/trending_tv_builder.dart';
import 'package:movie_app/src/views/home/components/tv_results_builder.dart';
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
        const SizedBox(height: 16),

        /// [trending movies]
        trendingMoviesBuilder(
          onMoreTap: () {},
          posterUrl: _configurationController.posterUrl,
          title: 'Trending',
          subtitle: 'Movies',
        ),
        const SizedBox(height: 22),

        /// [trending tv shows]
        trendingTvBuilder(
          onMoreTap: () {},
          posterUrl: _configurationController.posterUrl,
          title: 'Trending',
          subtitle: 'TV Series',
        ),
        const SizedBox(height: 22),

        // upcoming movies *
        movieResultBuilder(
          onMoreTap: () {},
          resultType: UPCOMING_STRING,
          state: _resultsController.upcommingMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Upcoming",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // on the air tv shows
        tvResultBuilder(
          onMoreTap: () {},
          resultType: ON_THE_AIR_STRING,
          state: _resultsController.onTheAirTvState,
          posterUrl: _configurationController.posterUrl,
          title: "On The Air",
          subtitle: "TV Series",
        ),
        const SizedBox(height: 22),

        // popular movies *
        movieResultBuilder(
          onMoreTap: () {},
          resultType: POPULAR_STRING,
          state: _resultsController.popularMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Popular",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // popular tv shows
        tvResultBuilder(
          onMoreTap: () {},
          resultType: POPULAR_STRING,
          state: _resultsController.popularTvState,
          posterUrl: _configurationController.posterUrl,
          title: "Popular",
          subtitle: "TV Series",
        ),
        const SizedBox(height: 22),

        // top rated movies *
        movieResultBuilder(
          onMoreTap: () {},
          resultType: TOP_RATED_STRING,
          state: _resultsController.topRatedMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Top Rated",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // top rated tv shows
        tvResultBuilder(
          onMoreTap: () {},
          resultType: TOP_RATED_STRING,
          state: _resultsController.topRatedTvState,
          posterUrl: _configurationController.posterUrl,
          title: "Top Rated",
          subtitle: "TV Series",
        ),
        const SizedBox(height: 22),

        // now playing movies *
        movieResultBuilder(
          onMoreTap: () {},
          resultType: NOW_PLAYING_STRING,
          state: _resultsController.nowPlayingMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Now Playing",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // airing today tv shows
        tvResultBuilder(
          onMoreTap: () {},
          resultType: AIRING_TODAY_STRING,
          state: _resultsController.airingTodayTvState,
          posterUrl: _configurationController.posterUrl,
          title: "Airing Today",
          subtitle: "TV Series",
        ),
        const SizedBox(height: 22),
        const SizedBox(height: 22),
      ],
    );
  }
}
