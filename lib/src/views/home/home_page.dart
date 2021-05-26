import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/controllers/popular_movies_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/services/popular_movies_service.dart';
import 'package:movie_app/src/views/home/components/widgets_block_builder.dart';
import 'components/app_bar.dart';
import 'components/img_slider.dart';

class HomePage extends StatelessWidget {
  final _utilityController = Get.find<UtilityController>();
  final _popularMoviesController = Get.find<PopularMoviesController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBarBuilder(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              imgSliderBuilder(),
              const SizedBox(height: 22),
              widgetsBlockBuilder(),
              TextButton(
                onPressed: () {
                  _popularMoviesController.getPopularMovies();
                },
                child: const Text('get popular movies'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
