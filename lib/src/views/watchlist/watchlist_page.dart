import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import '../../controllers/utility_controller.dart';
import 'components/watchlist_bottom_tabbar.dart';
import 'tabs/movie_watchlist.dart';
import 'tabs/tv_watchlist.dart';

class WatchlistPage extends StatelessWidget {
  WatchlistPage({Key? key}) : super(key: key);

  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            alignment: Alignment.centerLeft,
            height: 62,
            child: const Text(
              'Watchlist',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: l,
                // color: primaryWhite,
                color: primaryDarkBlue,
              ),
            ),
          ),

          // tabbar
          WatchlistTabbarComponent(tabMenuItems: tabItems),

          // tabs
          Obx(
            () => tabs[_utilityController.wacthlistTabbarCurrentIndex],
          ),
        ],
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     elevation: 0.6,
    //     toolbarHeight: 110,
    //     title: const Text('Watchlist'),
    //     bottom: searchTabbarComponent(tabMenuItems: searchTabs),
    //     actions: [
    //       IconButton(
    //           onPressed: () {},
    //           icon: const Icon(
    //             Icons.grid_view,
    //             size: 26,
    //             color: primaryDarkBlue,
    //           )),
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         // tabs
    //         Obx(
    //           () => _searchController.searchState.value == ViewState.idle
    //               ? _searchController.searchHistory.isEmpty
    //                   ? emptySearch()
    //                   : searchHistory()
    //               : tabs[_utilityController.searchTabbarCurrentIndex],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

List<String> tabItems = [
  'Movies',
  'TV Series',
];

List<Widget> tabs = [
  MovieWatchlist(),
  TvWatchlist(),
];
