import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/configs.dart';
import '../../../../../configs/strings.dart';
import '../../../../../controllers/details_controller.dart';
import '../../../../../controllers/results_controller.dart';
import '../../../../../global/loading_spinner.dart';
import '../../../../../helpers/widget_builder_helper.dart';
import '../movie%20_list/movie_list.dart';

class MovieRecommendedTab extends StatelessWidget {
  MovieRecommendedTab({Key? key}) : super(key: key);

  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_recommended',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: movieString,
            id: _resultsController.movieId,
            appendTo: recommendedSTring);
      },
      builder: (controller) => WidgetBuilderHelper(
        state: _detailsController.recommendedState.value,
        onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
        onErrorBuilder: const Center(
          child: Text('error while loading data ...'),
        ),
        onSuccessBuilder: _detailsController.recommendedMovie.value.results ==
                    null ||
                _detailsController.recommendedMovie.value.results!.isEmpty
            ? SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    'No Recommended Movies at the Moment',
                    style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                  ),
                ),
              )
            : Column(
                children: [
                  MovieList(
                      movies:
                          _detailsController.recommendedMovie.value.results ??
                              []),
                ],
              ),
      ),
    );
  }
}
