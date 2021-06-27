import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/components/bottom_tabbar.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/cast/cast_tab.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/reviews/reviews_tab.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/seasons/seasons_tab.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/tv_list/similar_list.dart';

import '../components/sliver_appbar_title.dart';
import 'components/tv_flexible_spacebar.dart';
import 'components/tv_flexible_spacebar_options.dart';
import 'tabs/about/tv_about_tab.dart';
import 'tabs/tv_list/recommended_list.dart';

class TvDetails extends StatelessWidget {
  // final TvResultsModel tv;

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();

  final _trendingResultsController = Get.find<TrendingResultsController>();

  TvDetails({
    Key? key,
    // required this.tv,
  }) : super(key: key);

  final scrollController = ScrollController();

  get primaryDark => null;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // initializing trending TV services
        if (_utilityController.isTvToday == true) {
          _trendingResultsController.getTrendingTvResults(
              timeWindow: dayString, page: '1');
        } else {
          _trendingResultsController.getTrendingTvResults(
              timeWindow: weekString, page: '1');
        }

        // reseting toinitial init state of popular/top rated/airing today/on the air TV services
        _resultsController.getTvResults(resultType: popularString);
        _resultsController.getTvResults(resultType: topRatedString);
        _resultsController.getTvResults(resultType: airingTodayString);
        _resultsController.getTvResults(resultType: onTheAirString);

        Get.offAllNamed('/dashboard');
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            id: "tv_details",
            init: _detailsController,
            initState: (_) {
              _detailsController.getDetails(
                  resultType: tvString, id: _resultsController.tvId);
              _utilityController.resetImgSliderIndex();
              _utilityController.resetTabbarState();
              _utilityController.resetHideShowState();
            },
            builder: (_) {
              return WidgetBuilderHelper(
                state: _detailsController.tvDetailState.value,
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
                          // initializing trending TV services
                          if (_utilityController.isTvToday == true) {
                            _trendingResultsController.getTrendingTvResults(
                                timeWindow: dayString, page: '1');
                          } else {
                            _trendingResultsController.getTrendingTvResults(
                                timeWindow: weekString, page: '1');
                          }

                          // reseting toinitial init state of popular/top rated/airing today/on the air TV services
                          _resultsController.getTvResults(
                              resultType: popularString);
                          _resultsController.getTvResults(
                              resultType: topRatedString);
                          _resultsController.getTvResults(
                              resultType: airingTodayString);
                          _resultsController.getTvResults(
                              resultType: onTheAirString);

                          Get.offAllNamed('/dashboard');
                        },
                      ),
                      title: SABT(
                          child: Text(
                        _detailsController.tvDetail.value.name ?? 'Title',
                        style: TextStyle(
                          color: primaryDark,
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
                            tvFlexibleSpacebarComponent(
                              tv: _detailsController.tvDetail.value,
                              height: 200,
                            ),

                            // ),
                            const SizedBox(height: 18),

                            // ratings / lists / bookmark options
                            tvFlexibleSpacebarOptions(
                                controller: _detailsController),
                          ],
                        ),
                      ),
                      bottom: bottomTabbarComponent(tabMenuItems: tabMenuItems),
                    ),

                    // body
                    // Obx(
                    //   () =>
                    GetBuilder(
                      id: 'tabs',
                      init: _utilityController,
                      initState: (_) {},
                      builder: (controller) => SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            tvTabs[_utilityController.tabbarCurrentIndex],
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
                // ),
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
  "Seasons",
  "Reviews",
  "Recommended",
  "Similar",
];

var tvTabs = <Widget>[
  TvAboutTab(),
  TvCastsTab(),
  SeasonsTab(),
  TvReviewTab(),
  TvRecommendedTab(),
  TvSimilarTab(),
];
