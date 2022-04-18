import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/search_controller.dart';
import '../../../../global/loading_spinner.dart';
import '../../../../helpers/widget_builder_helper.dart';
import '../../../details/tv_details/tabs/tv_list/tv_list.dart';

class TvSearchList extends StatelessWidget {
  TvSearchList({Key? key}) : super(key: key);

  final _searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'tv_search_result',
        init: _searchController,
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
