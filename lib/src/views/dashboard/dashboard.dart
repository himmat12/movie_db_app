import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/strings.dart';
import '../../controllers/auth_v3_controller.dart';
import '../../controllers/configuration_controller.dart';
import '../../controllers/results_controller.dart';
import '../../controllers/search_controller.dart';
import '../../controllers/trending_results_controller.dart';
import '../../controllers/utility_controller.dart';
import '../../helpers/widget_builder_helper.dart';
import '../../skeletons/bottom_nav_skeleton.dart';
import '../../skeletons/page_skeleton.dart';
import '../../utils/auth.dart';
import '../discover/discover_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../watchlist/watchlist_page.dart';

class DashboardPage extends StatelessWidget {
  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  // final _peopleController = Get.find<PeopleController>();
  // final _seasonController = Get.find<SeasonController>();
  // final _detailsController = Get.find<DetailsController>();
  final _authV3Controller = Get.find<AuthV3Controller>();
  final _searchController = Get.find<SearchController>();

  DashboardPage({Key? key}) : super(key: key);

  final List<Widget> userPages = [
    HomePage(),
    // const DiscoverPage(),
    WatchlistPage(),
    ProfilePage(),
  ];

  final List<Widget> guestPages = [
    HomePage(),
    const DiscoverPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(AlertDialog(
          title: const Text('Do you want to exit ?'),
          actions: [
            TextButton(
              onPressed: () {
                _authV3Controller.logoutV3();
                // _searchController.clearSearchHistoryMovie();
                // _searchController.clearSearchHistoryTv();
              },
              child: const Text('Signout'),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: const Text('Exit'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancle'),
            ),
          ],
        ));
        return false;
      },
      child: Scaffold(
          // appBar: AppBar(),
          bottomNavigationBar: Auth().isGuestLoggedIn
              ? guestBottomNavBarBuilder()
              : userBottomNavBarBuilder(),
          body: SafeArea(
            child: Obx(
              () => WidgetBuilderHelper(
                state: _configurationController.configState.value,
                onLoadingBuilder: pageSkeleton(),
                onErrorBuilder: const Center(
                  child: Text('error while initializing data ...'),
                ),
                onSuccessBuilder: SingleChildScrollView(
                  child: Column(
                    children: [
                      Auth().isGuestLoggedIn
                          ? guestPages[_utilityController.navCurrentIndex]
                          : userPages[_utilityController.navCurrentIndex],
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  // bottom nav bar
  Widget guestBottomNavBarBuilder() => SafeArea(
        child: Obx(
          () => WidgetBuilderHelper(
            state: _configurationController.configState.value,
            onLoadingBuilder: bottomNavSkeleton(),
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
                _resultsController.getMovieResults(
                    resultType: nowPlayingString);

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
                guestMenus.map(
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

  Widget userBottomNavBarBuilder() => SafeArea(
        child: Obx(
          () => WidgetBuilderHelper(
            state: _configurationController.configState.value,
            onLoadingBuilder: bottomNavSkeleton(),
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
                _resultsController.getMovieResults(
                    resultType: nowPlayingString);

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

var userMenus = <String>[
  "Discover",
  // "Discover",
  "Watchlist",
  "Profile",
];

var guestMenus = <String>[
  "Discover",
  // "Discover",
  "Profile",
];
