import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/movie%20_list/movie_list.dart';

class RecommendedTab extends StatelessWidget {
  RecommendedTab({Key? key}) : super(key: key);

  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();

  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieList(
            movies:
                _detailsController.movieDetail.value.recommendations!.results ??
                    []),
      ],
    );
  }
}
