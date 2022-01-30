import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';

class MovieList extends StatelessWidget with AvatarBuilderMixin {
  final List<MovieResultModel> movies;
  // final void Function()? onLongPress;

  final _configurationController = Get.find<ConfigurationController>();

  MovieList({
    required this.movies,
    // this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          itemBuilder: (context, index) => AbsorbPointer(
            absorbing: movies[index].posterPath == null ? true : false,
            child: movieThumbnailCard(
              // onLongPress: onLongPress,
              padding: const EdgeInsets.all(0),
              movie: movies[index],
              imageUrl:
                  '${_configurationController.posterUrl}${movies[index].posterPath}',
            ),
          ),
        ),
      ],
    );
  }
}
