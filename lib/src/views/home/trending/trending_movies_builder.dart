import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/strings.dart';
import '../../../controllers/trending_results_controller.dart';
import '../../../controllers/utility_controller.dart';
import '../../../global/add_more_pagination_btn.dart';
import '../../../global/movie_thumbnail_card.dart';
import '../../../global/switch_btn.dart';
import '../components/header_tile.dart';

class TrendingMoviesBuilder extends StatelessWidget {
  TrendingMoviesBuilder({required this.posterUrl, Key? key}) : super(key: key);

  final String posterUrl;

  final _utilityController = Get.find<UtilityController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  @override
  Widget build(BuildContext context) {
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
                "toggleOption": TrendingMovieSwitchBtnBuilder()
              });
            },
            title: "Trending",
            subtitle: "Movies",
            toggleOption: TrendingMovieSwitchBtnBuilder(),
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
                          itemBuilder: (context, index) =>
                              _trendingResultsController.trendingMovies[index]
                                              .posterPath ==
                                          null ||
                                      _trendingResultsController
                                              .trendingMovies[index]
                                              .posterPath ==
                                          ""
                                  ? AbsorbPointer(
                                      absorbing: true,
                                      child: MovieThumbnailCard(
                                          movie: _trendingResultsController
                                              .trendingMovies[index],
                                          imageUrl:
                                              '$posterUrl${_trendingResultsController.trendingMovies[index].posterPath}'),
                                    )
                                  : MovieThumbnailCard(
                                      movie: _trendingResultsController
                                          .trendingMovies[index],
                                      imageUrl:
                                          '$posterUrl${_trendingResultsController.trendingMovies[index].posterPath}')),
                      AddMorePaginationBtn(
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
}
