import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/add_more_pagination_btn.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/global/switch_btn.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/views/home/components/header_tile.dart';

Widget trendingMoviesBuilder({
  required String posterUrl,
}) {
  // ignore: avoid_print
  // print("trending movie builder builded");

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
                    ? dayString
                    : weekString);
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
            // initializing trending MOVIES services
            if (_utilityController.isMovieToday == true) {
              _trendingResultsController.getTrendingMovieResults(
                  timeWindow: dayString, page: '1');
            } else {
              _trendingResultsController.getTrendingMovieResults(
                  timeWindow: weekString, page: '1');
            }
            Get.toNamed('/trending_movie_list', arguments: {
              "title": "Trending Movies",
              "toggleOption": trendingMovieSwitchBtnBuilder()
            });
          },
          title: "Trending",
          subtitle: "Movies",
          toggleOption: trendingMovieSwitchBtnBuilder(),
        ),

        const SizedBox(height: 12),

        // horizontal scroll view
        Container(
          // color: primaryblue,
          height: 200,
          width: MediaQuery.of(Get.context!).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  children: [
                    ListView.builder(
                        itemExtent: 96,
                        cacheExtent: 1200,
                        semanticChildCount:
                            _trendingResultsController.trendingMovies.length,
                        itemCount:
                            _trendingResultsController.trendingMovies.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => movieThumbnailCard(
                            movie: _trendingResultsController
                                .trendingMovies[index],
                            imageUrl:
                                '$posterUrl${_trendingResultsController.trendingMovies[index].posterPath}')),
                    addMorePaginationBtn(
                        onTap: () {
                          _trendingResultsController
                              .loadMoreTrendingMoviesResults(
                                  timeWindow:
                                      _utilityController.isMovieToday == true
                                          ? dayString
                                          : weekString);
                        },
                        viewState: _trendingResultsController.movieViewState),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
