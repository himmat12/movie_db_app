import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/search_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/details/tv_details/tabs/tv_list/tv_list.dart';

class TvSearchList extends StatelessWidget {
  TvSearchList({Key? key}) : super(key: key);

  final _searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'tv_search_result',
        init: _searchController,
        initState: (_) {
          _searchController.setResultType(tvString);
        },
        builder: (controller) => Obx(
              () => WidgetBuilderHelper(
                state: _searchController.searchState.value,
                onLoadingBuilder:
                    Center(child: LoadingSpinner().fadingCircleSpinner),
                onErrorBuilder: const Center(
                  child: Text('error while loading data ...'),
                ),
                onSuccessBuilder: Column(
                  children: [
                    TvList(tv: _searchController.tvSearchResults),
                  ],
                ),
              ),
            ));
  }
}
