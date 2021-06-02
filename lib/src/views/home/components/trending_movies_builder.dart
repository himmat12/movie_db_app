import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/add_more_pagination_btn.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/global/more_btn.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/global/switch_btn.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';

import 'header_tile.dart';

Widget trendingMoviesBuilder({
  required String posterUrl,
}) {
  // ignore: avoid_print
  print("trending movie builder builded");

  final _resultsController = Get.find<ResultsController>();
  final _utilityController = Get.find<UtilityController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();

  var items = <Widget>[];

// returns listview items
  List<Widget> moviesList(List<MovieResultModel> movies) {
    items = List.from(
      movies.map((e) =>
          movieThumbnailCard(movie: e, imageUrl: '$posterUrl${e.posterPath}')),
    );

    // load more option
    items.add(
      addMorePaginationBtn(
          onTap: () {
            _trendingResultsController.loadMoreTrendingMoviesResults(
                timeWindow: _utilityController.isMovieToday == true
                    ? DAY_STRING
                    : WEEK_STRING);
          },
          viewState: _trendingResultsController.movieViewState),
    );

    return items;
  }

  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title & more option
        headerTile(
          onMoreTap: () {
            // navigate to movie lists page
          },
          title: "Trending",
          subtitle: "Movies",
          toggleOption: trendingMovieSwitchBtnBuilder(),
        ),

        const SizedBox(height: 12),

        // horizontal scroll view
        Container(
          // color: primaryblue,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                    children:
                        moviesList(_trendingResultsController.trendingMovies)),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
