import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';

Widget watchlistTabbarComponent({required List<String> tabMenuItems}) {
  final _scrollController = ScrollController();

  return Container(
    height: kToolbarHeight,
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
  );
}

// helper tabbar items
Widget tabbarItem({
  required int index,
  required String title,
  required ScrollController controller,
}) {
  final _utilityController = Get.find<UtilityController>();

  return GestureDetector(
    onTap: () {
      _utilityController.setWatchlistTabbarIndex(index);
    },
    child: Container(
      height: 80,
      color: Colors.transparent,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GetBuilder(
        id: 'watchlistTabBar',
        init: _utilityController,
        builder: (controller) => Text(
          title,
          style: TextStyle(
            fontSize: m - 6,
            color: _utilityController.wacthlistTabbarCurrentIndex == index
                ? primaryDarkBlue.withOpacity(0.8)
                : primaryDarkBlue.withOpacity(0.5),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
