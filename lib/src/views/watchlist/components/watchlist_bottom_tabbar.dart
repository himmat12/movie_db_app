import 'package:flutter/material.dart';

import '../../details/components/bottom_tabbar.dart';

class WatchlistTabbarComponent extends StatelessWidget {
  WatchlistTabbarComponent({required this.tabMenuItems, Key? key})
      : super(key: key);
  final List<String> tabMenuItems;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
              return TabbarItem(
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
}
