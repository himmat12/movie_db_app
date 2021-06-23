import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/skeletons/bottom_nav_skeleton.dart';
import 'package:movie_app/src/skeletons/page_skeleton.dart';
import 'package:movie_app/src/views/discover/discover_page.dart';
import 'package:movie_app/src/views/home/home_page.dart';
import 'package:movie_app/src/views/mylist/mylist_page.dart';
import 'package:movie_app/src/views/profile/profile_page.dart';

class DashboardPage extends StatelessWidget {
  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _peopleController = Get.find<PeopleController>();
  final _seasonController = Get.find<SeasonController>();

  DashboardPage({Key? key}) : super(key: key);

  final List<Widget> pages = [
    HomePage(),
    const DiscoverPage(),
    const MyListPage(),
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
                exit(1);
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
          bottomNavigationBar: Obx(
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
                  _utilityController.setBottomNavIndex(newIndex);
                },
                type: BottomNavigationBarType.fixed,
                unselectedFontSize: 0,
                selectedFontSize: 0,
                selectedIconTheme: const IconThemeData(color: Colors.blue),
                selectedItemColor: Colors.blue,
                items: List.from(
                  menus.map(
                    (e) => BottomNavigationBarItem(
                      icon: Text(e),
                      label: "",
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Obx(
            () => WidgetBuilderHelper(
              state: _configurationController.configState.value,
              onLoadingBuilder: pageSkeleton(),
              onErrorBuilder: const Center(
                child: Text('error while initializing data ...'),
              ),
              onSuccessBuilder: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    pages[_utilityController.navCurrentIndex],
                  ],
                ),
              )),
            ),
          )),
    );
  }
}

var menus = <String>["Home", "Discover", "My List", "Profile"];
