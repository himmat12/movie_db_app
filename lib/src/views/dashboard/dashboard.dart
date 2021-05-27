import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/models/api_configuration_model.dart';
import 'package:movie_app/src/views/home/home_page.dart';

class DashboardPage extends StatelessWidget {
  final _resultsController = Get.find<ResultsController>();
  final _utilityController = Get.find<UtilityController>();
  final _configurationController = Get.find<ConfigurationController>();

  List<Widget> pages = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _resultsController,
      initState: (_) {
        _configurationController.getConfigurations();
        _resultsController.getTvResults(resultType: POPULAR_STRING, page: "1");
        _resultsController.getMovieResults(
            resultType: NOW_PLAYING_STRING, page: "1");
      },
      builder: (_) {
        return Scaffold(
            // appBar: AppBar(),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
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
            body: Obx(
              () => WidgetBuilderHelper(
                state: _configurationController.configState.value,
                onLoadingBuilder: const Center(
                  child: Text('initializing configurations'),
                ),
                onErrorBuilder: const Center(
                  child: Text('error while initializing configurations'),
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
      },
    );
  }
}

List<String> menus = ["Home", "Discover", "My List", "Profile"];
