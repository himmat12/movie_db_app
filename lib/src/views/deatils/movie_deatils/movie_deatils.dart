import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/components/bottom_tabbar.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/components/movie_flexible_spacebar_options.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/about/movie_about_tab.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/casts/casts_tab.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/movie%20_list/recommended_list.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/reviews/reviews_tab.dart';

import '../components/sliver_appbar_title.dart';
import 'components/movie_flexible_spacebar.dart';
import 'tabs/movie _list/similar_list.dart';

class MoviesDetails extends StatelessWidget {
  final String movieId;

  MoviesDetails({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final _detailsController = Get.find<DetailsController>();

  final _utilityController = Get.find<UtilityController>();

  final scrollController = ScrollController();

  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();

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

        // reseting toinitial init state of popular/top rated/upcomming/now playing MOVIES services
        _resultsController.getMovieResults(resultType: popularString);
        _resultsController.getMovieResults(resultType: topRatedString);
        _resultsController.getMovieResults(resultType: upcomingString);
        _resultsController.getMovieResults(resultType: nowPlayingString);

        Get.offAllNamed('/');
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            id: 'movie_details',
            init: _detailsController,
            initState: (_) {
              // ignore: avoid_print
              // print(movieId);

              _detailsController.getDetails(
                  resultType: movieString, id: movieId);
              _utilityController.resetImgSliderIndex();
              _utilityController.resetTabbarState();
              _utilityController.resetHideShowState();
              // ignore: avoid_print
              // print("initialized ...");
            },
            builder: (_) {
              return WidgetBuilderHelper(
                state: _detailsController.movieDetailState.value,
                onLoadingBuilder:
                    Center(child: LoadingSpinner.horizontalLoading),
                onErrorBuilder: const Center(
                  child: Text('error while initializing data...'),
                ),
                onSuccessBuilder: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0.5,
                      forceElevated: true,
                      leading: SABTN(
                        onBack: () {
                          // initializing trending MOVIES services
                          if (_utilityController.isMovieToday == true) {
                            _trendingResultsController.getTrendingMovieResults(
                                timeWindow: dayString, page: '1');
                          } else {
                            _trendingResultsController.getTrendingMovieResults(
                                timeWindow: weekString, page: '1');
                          }

                          // reseting toinitial init state of popular/top rated/upcomming/now playing MOVIES services
                          _resultsController.getMovieResults(
                              resultType: popularString);
                          _resultsController.getMovieResults(
                              resultType: topRatedString);
                          _resultsController.getMovieResults(
                              resultType: upcomingString);
                          _resultsController.getMovieResults(
                              resultType: nowPlayingString);

                          Get.offAllNamed('/');
                        },
                      ),
                      title: SABT(
                          child: Text(
                        _detailsController.movieDetail.value.title ?? 'Title',
                        style: TextStyle(
                          color: primaryDarkBlue.withOpacity(0.9),
                        ),
                      )),
                      expandedHeight: _utilityController.titlevisiblity == false
                          ? 446
                          : 440,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          children: [
                            // slider img/poster/title
                            movieFlexibleSpacebarComponent(
                              movie: _detailsController.movieDetail.value,
                              height: 200,
                            ),

                            const SizedBox(height: 18),

                            // ratings / lists / bookmark options
                            movieFlexibleSpacebarOptions(),
                          ],
                        ),
                      ),
                      bottom: bottomTabbarComponent(tabMenuItems: tabMenuItems),
                    ),

                    // body
                    GetBuilder(
                      id: 'tabs',
                      init: _utilityController,
                      builder: (controller) => SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            movieTabs[_utilityController.tabbarCurrentIndex],
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

var tabMenuItems = <String>[
  "Overview",
  "Cast",
  "Reviews",
  "Recommended",
  "Similar",
];

var movieTabs = <Widget>[
  MovieAboutTab(),
  MovieCastsTab(),
  MovieReviewTab(),
  MovieRecommendedTab(),
  MovieSimilarTab(),
];
