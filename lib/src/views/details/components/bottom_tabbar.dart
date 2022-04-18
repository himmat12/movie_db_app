import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/utility_controller.dart';

PreferredSizeWidget? bottomTabbarComponent(
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

  return GestureDetector(
    onTap: () {
      _utilityController.setTabbarIndex(index);
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
        id: 'bottomTabBar',
        init: _utilityController,
        builder: (controller) => Text(
          title,
          style: TextStyle(
            fontSize: m - 6,
            color: _utilityController.tabbarCurrentIndex == index
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
