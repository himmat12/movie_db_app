import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/strings.dart';
import '../../controllers/configuration_controller.dart';
import '../../controllers/results_controller.dart';
import 'components/app_bar.dart';
import 'results/movies_results_builder.dart';
import 'results/tv_results_builder.dart';
import 'trending/trending_movies_builder.dart';
import 'trending/trending_tv_builder.dart';

class HomePage extends StatelessWidget {
  final _configurationController = Get.find<ConfigurationController>();
  final _resultsController = Get.find<ResultsController>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // appBarBuilder(),
        AppBarBuilder(),
        const SizedBox(height: 16),

        /// [trending movies]
        TrendingMoviesBuilder(posterUrl: _configurationController.posterUrl),
        const SizedBox(height: 22),

        /// [trending tv shows]
        TrendingTvBuilder(posterUrl: _configurationController.posterUrl),
        const SizedBox(height: 22),

        // upcoming movies *
        MovieResultBuilder(
          onMoreTap: () {},
          resultType: upcomingString,
          state: _resultsController.upcommingMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Upcoming",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // on the air tv shows
        TvResultBuilder(
          onMoreTap: () {},
          resultType: onTheAirString,
          state: _resultsController.onTheAirTvState,
          posterUrl: _configurationController.posterUrl,
          title: "On The Air",
          subtitle: "TV Series",
        ),
        const SizedBox(height: 22),

        // popular movies *
        MovieResultBuilder(
          onMoreTap: () {},
          resultType: popularString,
          state: _resultsController.popularMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Popular",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // popular tv shows
        TvResultBuilder(
          onMoreTap: () {},
          resultType: popularString,
          state: _resultsController.popularTvState,
          posterUrl: _configurationController.posterUrl,
          title: "Popular",
          subtitle: "TV Series",
        ),
        const SizedBox(height: 22),

        // top rated movies *
        MovieResultBuilder(
          onMoreTap: () {},
          resultType: topRatedString,
          state: _resultsController.topRatedMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Top Rated",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // top rated tv shows
        TvResultBuilder(
          onMoreTap: () {},
          resultType: topRatedString,
          state: _resultsController.topRatedTvState,
          posterUrl: _configurationController.posterUrl,
          title: "Top Rated",
          subtitle: "TV Series",
        ),
        const SizedBox(height: 22),

        // now playing movies *
        MovieResultBuilder(
          onMoreTap: () {},
          resultType: nowPlayingString,
          state: _resultsController.nowPlayingMoviesState,
          posterUrl: _configurationController.posterUrl,
          title: "Now Playing",
          subtitle: "Movies",
        ),
        const SizedBox(height: 22),

        // airing today tv shows
        TvResultBuilder(
          onMoreTap: () {},
          resultType: airingTodayString,
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
