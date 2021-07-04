import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';

class HomeMovieresultsList extends StatelessWidget with LoadingSpinnerMixin {
  final String? title;
  final String resultType;
  final Rx<ViewState> state;

  HomeMovieresultsList({
    required this.state,
    required this.resultType,
    Key? key,
    this.title,
  }) : super(key: key);

  final _configurationController = Get.find<ConfigurationController>();
  final _resultsController = Get.find<ResultsController>();

// returns respected movies list according to the given resultType parameter
  List<MovieResultModel>? getItem(String resultType) {
    switch (resultType) {
      case popularString:
        return _resultsController.popularMovies;
      case topRatedString:
        return _resultsController.topRatedMovies;
      case upcomingString:
        return _resultsController.upcommingMovies;
      case nowPlayingString:
        return _resultsController.nowPlayingMovies;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _resultsController.getMovieResults(resultType: resultType, page: '1');
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(title ?? 'title'),
              const SizedBox(width: 8),
            ],
          ),
          elevation: 0.5,
        ),
        body: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              _resultsController.loadMoreMoviesResults(resultType: resultType);
            }
            return false;
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 28),
                GetBuilder(
                  id: 'movies_result',
                  init: _resultsController,
                  builder: (controller) {
                    return WidgetBuilderHelper(
                      state: state.value,
                      onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
                      onSuccessBuilder: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        semanticChildCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        cacheExtent: 2400,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 186,
                        ),
                        itemBuilder: (context, index) => movieThumbnailCard(
                          padding: const EdgeInsets.all(0),
                          movie: getItem(resultType)![index],
                          imageUrl:
                              '${_configurationController.posterUrl}${getItem(resultType)![index].posterPath}',
                        ),
                      ),
                      onErrorBuilder: const Center(
                        child: Text('error while loading data ...'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
