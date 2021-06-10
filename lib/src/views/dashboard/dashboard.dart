import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
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

  List<Widget> pages = [
    HomePage(),
    DiscoverPage(),
    MyListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ));
  }
}

var menus = <String>["Home", "Discover", "My List", "Profile"];
