import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/tv_thumbnail_card.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/results/tv_result_model.dart';

class HomeTvResultList extends StatelessWidget with LoadingSpinnerMixin {
  final List<TvResultsModel> tv;
  final String? title;

  HomeTvResultList({
    Key? key,
    required this.tv,
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
              itemCount: tv.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 186,
              ),
              itemBuilder: (context, index) => tvThumbnailCard(
                padding: const EdgeInsets.all(0),
                tv: tv[index],
                imageUrl:
                    '${_configurationController.posterUrl}${tv[index].posterPath}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
