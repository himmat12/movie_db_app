import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../configs/configs.dart';
import '../../../controllers/base_controller.dart';
import '../../../controllers/search_controller.dart';
import '../../../controllers/utility_controller.dart';
import 'components/empty_search.dart';
import 'components/search_bottom_tabbar.dart';
import 'components/search_history_list.dart';
import 'tabs/movies_search_list.dart';
import 'tabs/tv_search_list.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final _utilityController = Get.find<UtilityController>();
  final _searchController = Get.find<SearchController>();

  final _query = TextEditingController();

  final textFieldDebouncer =
      Debouncer(delay: const Duration(milliseconds: 800));
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.6,
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.clear,
              color: primaryDarkBlue,
            ),
          ),
          backgroundColor: primaryWhite,
          toolbarHeight: 60,
          title: TextFormField(
            controller: _query,
            onChanged: (value) {
              textFieldDebouncer.call(() {
                if (value.trim().isNotEmpty ||
                    value.trim() != "" ||
                    value.trim().isBlank != true) {
                  _searchController.search(
                      query: value.trim(),
                      resultType: _searchController.resultType.value);
                  _utilityController.searchTabbarCurrentIndex == 0
                      ? _searchController.setSearchHistoryMovie(_query.text)
                      : _searchController.setSearchHistoryTv(_query.text);
                }
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
          ),
          bottom: searchTabbarComponent(tabMenuItems: searchTabs),
          actions: [
            IconButton(
                onPressed: () {
                  if (_query.text.trim().isNotEmpty ||
                      _query.text.trim() != "" ||
                      _query.text.trim().isBlank != true) {
                    _searchController.search(
                        query: _query.text.trim(),
                        resultType: _searchController.resultType.value);
                    _utilityController.searchTabbarCurrentIndex == 0
                        ? _searchController.setSearchHistoryMovie(_query.text)
                        : _searchController.setSearchHistoryTv(_query.text);
                  }
                },
                icon: const Icon(
                  Icons.search,
                  size: 26,
                  color: primaryDarkBlue,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // tabs
              Obx(() {
                if (_utilityController.searchTabbarCurrentIndex == 0) {
                  if (_searchController.searchState.value == ViewState.idle) {
                    if (_searchController.searchHistoryMovie.isEmpty) {
                      return const EmptySearch();
                    }
                    return SearchHistory(
                      searchHistory: _searchController.searchHistoryMovie,
                      type: SearchHistoryType.movie,
                    );
                  }
                } else if (_utilityController.searchTabbarCurrentIndex == 1) {
                  if (_searchController.searchState.value == ViewState.idle) {
                    if (_searchController.searchHistoryTv.isEmpty) {
                      return const EmptySearch();
                    }
                    return SearchHistory(
                      searchHistory: _searchController.searchHistoryTv,
                      type: SearchHistoryType.tv,
                    );
                  }
                }
                // }
                return tabs[_utilityController.searchTabbarCurrentIndex];
              }),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> searchTabs = [
  'Movies',
  'TV Series',
  // 'People',
];

List<Widget> tabs = [
  MovieSearchList(key: const ValueKey('movie_search_result')),
  TvSearchList(key: const ValueKey('tv_search_result')),
  // PeopleSearchList(),
];
