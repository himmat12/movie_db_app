import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_v3_controller.dart';
import '../../controllers/configuration_controller.dart';
import '../../controllers/utility_controller.dart';
import '../../helpers/widget_builder_helper.dart';
import '../../skeletons/page_skeleton.dart';
import '../../utils/auth.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../watchlist/watchlist_page.dart';
import 'components/guest_bottom_navbar_builder.dart';
import 'components/user_bottom_navbar_builder.dart';

class DashboardPage extends StatelessWidget {
  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  // final _resultsController = Get.find<ResultsController>();
  // final _trendingResultsController = Get.find<TrendingResultsController>();
  // final _peopleController = Get.find<PeopleController>();
  // final _seasonController = Get.find<SeasonController>();
  // final _detailsController = Get.find<DetailsController>();
  final _authV3Controller = Get.find<AuthV3Controller>();
  // final _searchController = Get.find<SearchController>();

  DashboardPage({Key? key}) : super(key: key);

  final List<Widget> userPages = [
    HomePage(),
    // const DiscoverPage(),
    WatchlistPage(),
    const ProfilePage(),
  ];

  final List<Widget> guestPages = [
    HomePage(),
    // const DiscoverPage(),
    const ProfilePage(),
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
              ? GuestBottomNavBarBuilder()
              : UserBottomNavBarBuilder(),
          body: SafeArea(
            child: GetX<UtilityController>(
              initState: (_) {
                _.controller?.resetBottomNavState();
              },
              builder: (_) => WidgetBuilderHelper(
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
}
