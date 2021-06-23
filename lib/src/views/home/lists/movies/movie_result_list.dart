import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';

class HomeMovieresultsList extends StatelessWidget with LoadingSpinnerMixin {
  final List<MovieResultModel> movies;
  final String? title;

  HomeMovieresultsList({
    Key? key,
    required this.movies,
    this.title,
  }) : super(key: key);

  final _configurationController = Get.find<ConfigurationController>();
  final _resultsController = Get.find<ResultsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'title'),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 28),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 186,
              ),
              itemBuilder: (context, index) => movieThumbnailCard(
                padding: const EdgeInsets.all(0),
                movie: movies[index],
                imageUrl:
                    '${_configurationController.posterUrl}${movies[index].posterPath}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
