import 'package:flutter/material.dart';
import 'package:movie_app/src/views/home/home_page.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: 0,
        onTap: (index) {},
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        items: List.from(
          menus.map(
            (e) => BottomNavigationBarItem(
              icon: Text(e),
              label: "",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
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
