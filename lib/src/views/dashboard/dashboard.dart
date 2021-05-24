import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/views/home/home_page.dart';

class DashboardPage extends StatelessWidget {
  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
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
        () => SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              pages[_utilityController.navCurrentIndex],
            ],
          )),
        ),
      ),
    );
  }
}

List<String> menus = ["Home", "Discover", "My List", "Profile"];

List<Widget> pages = [
  HomePage(),
  HomePage(),
  HomePage(),
  HomePage(),
];
