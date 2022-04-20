import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/strings.dart';
import '../../../controllers/configuration_controller.dart';
import '../../../controllers/results_controller.dart';
import '../../../controllers/trending_results_controller.dart';
import '../../../controllers/utility_controller.dart';
import '../../../helpers/widget_builder_helper.dart';
import '../../../skeletons/bottom_nav_skeleton.dart';

class UserBottomNavBarBuilder extends StatelessWidget {
  UserBottomNavBarBuilder({Key? key}) : super(key: key);

  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => WidgetBuilderHelper(
          state: _configurationController.configState.value,
          onLoadingBuilder: const BottomNavSkeleton(),
          onErrorBuilder: const Center(
            child: Text('error while initializing data...'),
          ),
          onSuccessBuilder: BottomNavigationBar(
            elevation: 0,
            currentIndex: _utilityController.navCurrentIndex,
            onTap: (newIndex) {
              // initializing trending MOVIES services
              if (_utilityController.isMovieToday == true) {
                _trendingResultsController.getTrendingMovieResults(
                    timeWindow: dayString, page: '1');
              } else {
                _trendingResultsController.getTrendingMovieResults(
                    timeWindow: weekString, page: '1');
              }

              // initializing trending TV services
              if (_utilityController.isTvToday == true) {
                _trendingResultsController.getTrendingTvResults(
                    timeWindow: dayString, page: '1');
              } else {
                _trendingResultsController.getTrendingTvResults(
                    timeWindow: weekString, page: '1');
              }

              // reseting toinitial init state of popular/top rated/upcomming/now playing MOVIES services
              _resultsController.getMovieResults(resultType: popularString);
              _resultsController.getMovieResults(resultType: topRatedString);
              _resultsController.getMovieResults(resultType: upcomingString);
              _resultsController.getMovieResults(resultType: nowPlayingString);

              // reseting toinitial init state of popular/top rated/airing today/on the air TV services
              _resultsController.getTvResults(resultType: popularString);
              _resultsController.getTvResults(resultType: topRatedString);
              _resultsController.getTvResults(resultType: airingTodayString);
              _resultsController.getTvResults(resultType: onTheAirString);

              _utilityController.setBottomNavIndex(newIndex);
            },
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 0,
            selectedFontSize: 0,
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            selectedItemColor: Colors.blue,
            items: List.from(
              userMenus.map(
                (e) => BottomNavigationBarItem(
                  icon: Text(e),
                  label: "",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var userMenus = <String>[
  "Discover",
  // "Discover",
  "Watchlist",
  "Profile",
];
