import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/configs.dart';
import '../../../../../controllers/details_controller.dart';
import '../../../../../global/loading_spinner.dart';
import '../../../../../helpers/widget_builder_helper.dart';
import '../movie%20_list/movie_list.dart';

class MoviesCollectionList extends StatelessWidget {
  MoviesCollectionList({required this.collectionId, Key? key})
      : super(key: key);

  final String collectionId;

  final _detailsController = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
            _detailsController.movieDetail.value.belongsToCollection!.name ??
                "collection name"),
      ),
      body: GetBuilder(
        id: 'movie_collections',
        init: _detailsController,
        initState: (_) {
          _detailsController.getCollectionsDetails(collectionId: collectionId);
        },
        builder: (controller) => WidgetBuilderHelper(
          state: _detailsController.collectionsDetailsState.value,
          onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
          onErrorBuilder: const Center(
            child: Text('error while loading data ...'),
          ),
          onSuccessBuilder: _detailsController.movieCollections.isEmpty
              ? SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      'No Movies at the Moment',
                      style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      MovieList(movies: _detailsController.movieCollections),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
