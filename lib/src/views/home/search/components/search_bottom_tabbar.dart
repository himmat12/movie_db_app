import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../configs/strings.dart';
import '../../../../controllers/search_controller.dart';
import '../../../../controllers/utility_controller.dart';

PreferredSizeWidget? searchTabbarComponent(
    {required List<String> tabMenuItems}) {
  final _scrollController = ScrollController();

  return PreferredSize(
    preferredSize: Size(MediaQuery.of(Get.context!).size.width, kToolbarHeight),
    child: Container(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: List.from(tabMenuItems.map((e) {
              int index = tabMenuItems.indexOf(e);
              return tabbarItem(
                index: index,
                title: e,
                controller: _scrollController,
              );
            })),
          ),
        ),
      ),
    ),
  );
}

// helper tabbar items
Widget tabbarItem({
  required int index,
  required String title,
  required ScrollController controller,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _searchController = Get.find<SearchController>();

  return GestureDetector(
    onTap: () {
      switch (index) {
        case 0:
          _searchController.setResultType(movieString);
          // _searchController.movieSearchResults.clear();
          // _searchController.resetSearchState();
          break;
        case 1:
          _searchController.setResultType(tvString);
          // _searchController.tvSearchResults.clear();
          // _searchController.resetSearchState();
          break;
        case 2:
          _searchController.setResultType(personString);
          break;
        default:
          break;
      }

      _utilityController.setSearchTabbarIndex(index);
    },
    child: Container(
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child:
          //
          //Obx(() =>
          GetBuilder(
        id: 'searchTabBar',
        init: _utilityController,
        builder: (controller) => Text(
          title,
          style: TextStyle(
            fontSize: m - 6,
            color: _utilityController.searchTabbarCurrentIndex == index
                ? primaryDarkBlue.withOpacity(0.8)
                : primaryDarkBlue.withOpacity(0.5),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ),
    ),
  );
}
