import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';

class HomeTrendingMovieList extends StatelessWidget with LoadingSpinnerMixin {
  final Widget? toggleOption;
  final String? title;

  HomeTrendingMovieList({
    Key? key,
    this.toggleOption,
    this.title,
  }) : super(key: key);

  final _configurationController = Get.find<ConfigurationController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(title ?? 'title'),
            const SizedBox(width: 8),
            toggleOption ?? const SizedBox.shrink(),
          ],
        ),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 28),
            Obx(
              () => WidgetBuilderHelper(
                state: _trendingResultsController.movieViewState,
                onLoadingBuilder: LoadingSpinner.fadingCircleSpinner,
                onSuccessBuilder: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _trendingResultsController.trendingMovies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 186,
                  ),
                  itemBuilder: (context, index) => movieThumbnailCard(
                    padding: const EdgeInsets.all(0),
                    movie: _trendingResultsController.trendingMovies[index],
                    imageUrl:
                        '${_configurationController.posterUrl}${_trendingResultsController.trendingMovies[index].posterPath}',
                  ),
                ),
                onErrorBuilder: const Center(
                  child: Text('error while loading data ...'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
