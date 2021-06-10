import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/movie%20_list/movie_list.dart';

class MovieSimilarTab extends StatelessWidget {
  MovieSimilarTab({Key? key}) : super(key: key);

  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();
  final _configurationController = Get.find<ConfigurationController>();

  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_similar',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: MOVIE_STRING,
            id: _resultsController.movie.id!,
            appendTo: SIMILAR_STRING);
      },
      builder: (controller) => WidgetBuilderHelper(
        state: _detailsController.similarState.value,
        onLoadingBuilder: LoadingSpinner.fadingCircleSpinner,
        onErrorBuilder: const Center(
          child: Text('error while loading data ...'),
        ),
        onSuccessBuilder: _detailsController.similarMovie.value.results == null
            ? Center(
                child: Text(
                  'No Similar Movies at the Moment',
                  style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                ),
              )
            : Column(
                children: [
                  MovieList(
                      movies:
                          _detailsController.similarMovie.value.results ?? []),
                ],
              ),
      ),
    );
  }
}
