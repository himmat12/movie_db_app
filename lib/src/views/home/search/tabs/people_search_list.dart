import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/search_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';

class PeopleSearchList extends StatelessWidget {
  PeopleSearchList({Key? key}) : super(key: key);

  final _searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: 'people_search_result',
        init: _searchController,
        initState: (_) {
          _searchController.setResultType(personString);
        },
        builder: (controller) => Obx(
              () => WidgetBuilderHelper(
                state: _searchController.searchState.value,
                onLoadingBuilder:
                    Center(child: LoadingSpinner().fadingCircleSpinner),
                onErrorBuilder: const Center(
                  child: Text('error while loading data ...'),
                ),
                onSuccessBuilder:
                    //  ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: _searchController.movieSearchResults.length,
                    //   itemBuilder: (context, index) => Text(
                    //       _searchController.movieSearchResults[index].title ??
                    //           "title"),
                    // )
                    Column(
                  children: [
                    // MovieList(movies: _searchController.movieSearchResults),
                    const SizedBox(height: 18),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchController.peopleSearchResults.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.offAllNamed('/people_details');
                        },
                        child: Text(
                            _searchController.peopleSearchResults[index].name ??
                                "name"),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
