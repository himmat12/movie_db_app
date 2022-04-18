import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../controllers/search_controller.dart';

enum SearchHistoryType { movie, tv }

class SearchHistory extends StatelessWidget {
  SearchHistory({
    required this.searchHistory,
    required this.type,
    Key? key,
  }) : super(key: key);

  final List searchHistory;
  final SearchHistoryType type;

  final _searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  type == SearchHistoryType.movie
                      ? _searchController.clearSearchHistoryMovie()
                      : _searchController.clearSearchHistoryTv();
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
          itemCount: searchHistory.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                _searchController.search(
                    query: searchHistory[index],
                    resultType: _searchController.resultType.value);
              },
              title: Text(
                searchHistory[index],
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
  }
}
