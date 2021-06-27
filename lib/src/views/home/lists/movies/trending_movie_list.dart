import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';

class HomeTrendingMovieList extends StatelessWidget with LoadingSpinnerMixin {
  final Widget? toggleOption;
  final String? title;

  HomeTrendingMovieList({
    Key? key,
    this.toggleOption,
    this.title,
  }) : super(key: key);

  final _configurationController = Get.find<ConfigurationController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // initializing trending MOVIES services
        if (_utilityController.isMovieToday == true) {
          _trendingResultsController.getTrendingMovieResults(
              timeWindow: dayString, page: '1');
        } else {
          _trendingResultsController.getTrendingMovieResults(
              timeWindow: weekString, page: '1');
        }
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(title ?? 'title'),
              const SizedBox(width: 8),
              toggleOption ?? const SizedBox.shrink(),
            ],
          ),
          elevation: 0.5,
        ),
        body: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              _trendingResultsController.loadMoreTrendingMoviesResults(
                  timeWindow: _utilityController.isMovieToday == true
                      ? dayString
                      : weekString);
            }
            return false;
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 28),
                GetBuilder(
                  id: 'trending_movies_list',
                  init: _trendingResultsController,
                  builder: (controller) {
                    return WidgetBuilderHelper(
                      state: _trendingResultsController.movieViewState,
                      onLoadingBuilder: LoadingSpinner.fadingCircleSpinner,
                      onSuccessBuilder: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            _trendingResultsController.trendingMovies.length,
                        cacheExtent: 2400,
                        semanticChildCount:
                            _trendingResultsController.trendingMovies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 186,
                        ),
                        itemBuilder: (context, index) => movieThumbnailCard(
                          padding: const EdgeInsets.all(0),
                          movie:
                              _trendingResultsController.trendingMovies[index],
                          imageUrl:
                              '${_configurationController.posterUrl}${_trendingResultsController.trendingMovies[index].posterPath}',
                        ),
                      ),
                      onErrorBuilder: const Center(
                        child: Text('error while loading data ...'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
