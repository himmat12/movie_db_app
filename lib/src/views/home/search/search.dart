import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../configs/configs.dart';
import '../../../controllers/base_controller.dart';
import '../../../controllers/search_controller.dart';
import '../../../controllers/utility_controller.dart';
import 'components/search_bottom_tabbar.dart';
import 'tabs/movies_search_list.dart';
import 'tabs/tv_search_list.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final _utilityController = Get.find<UtilityController>();
  final _searchController = Get.find<SearchController>();

  final _query = TextEditingController();

  final textFieldDebouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: TextField(
          controller: _query,

          // onSubmitted: (value) {
          //   if (value.trim().isNotEmpty ||
          //       value.trim() != "" ||
          //       value.trim().isBlank != true) {
          //     _searchController.search(
          //         query: value.trim(),
          //         resultType: _searchController.resultType.value);
          //   }
          // },
          onChanged: (value) {
            if (value.trim().isNotEmpty ||
                value.trim() != "" ||
                value.trim().isBlank != true) {
              _searchController.search(
                  query: value.trim(),
                  resultType: _searchController.resultType.value);
            }
          },
          autofocus: true,
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
                  _searchController.setSearchHistory(_query.text);
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
            Obx(
              () => _searchController.searchState.value == ViewState.idle
                  ? _searchController.searchHistory.isEmpty
                      ? emptySearch()
                      : searchHistory()
                  : tabs[_utilityController.searchTabbarCurrentIndex],
            ),
          ],
        ),
      ),
    );
  }

  // search history
  Widget searchHistory() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent searches',
                  style: TextStyle(
                    color: primaryDarkBlue.withOpacity(0.8),
                    fontSize: n,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _searchController.clearSearchHistory();
                  },
                  child: const Text(
                    'Clear all',
                    style: TextStyle(
                      color: primaryblue,
                      fontSize: n,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _searchController.searchHistory.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  _searchController.search(
                      query: _searchController.searchHistory[index],
                      resultType: _searchController.resultType.value);
                },
                title: Text(
                  _searchController.searchHistory[index],
                  style: TextStyle(
                    color: primaryDarkBlue.withOpacity(0.8),
                  ),
                ),
                leading: const Icon(Icons.history),
                trailing: const Icon(
                  Icons.launch,
                  size: 18,
                  color: primaryblue,
                ),
              );
            },
          ),
        ],
      );

// clear search history
  Widget emptySearch() => Container(
        height: 200,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 48,
              color: primaryDarkBlue.withOpacity(0.6),
            ),
            Text(
              'No search history yet',
              style: TextStyle(
                color: primaryDarkBlue.withOpacity(0.8),
                fontSize: n,
              ),
            ),
          ],
        ),
      );
}

List<String> searchTabs = [
  'Movies',
  'TV Series',
  // 'People',
];

List<Widget> tabs = [
  MovieSearchList(),
  TvSearchList(),
  // PeopleSearchList(),
];
