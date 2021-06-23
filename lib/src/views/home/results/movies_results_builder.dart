import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/add_more_pagination_btn.dart';
import 'package:movie_app/src/global/movie_thumbnail_card.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';

import '../components/header_tile.dart';

Widget movieResultBuilder({
  String? title,
  String? subtitle,
  Widget? trailingBtn,
  required String resultType,
  required String posterUrl,
  required Rx<ViewState> state,
  void Function()? onMoreTap,
}) {
  // ignore: avoid_print
  // print("$resultType movie builder builded");

  final _resultsController = Get.find<ResultsController>();

  var items = <Widget>[];

// returns respected movies list according to the given resultType parameter
  RxList<MovieResultModel>? getItem(String resultType) {
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

// returns listview items
  List<Widget> moviesList(List<MovieResultModel> movies) {
    items = List.from(
      movies.map((e) =>
          movieThumbnailCard(movie: e, imageUrl: '$posterUrl${e.posterPath}')),
    );

    // load more option
    items.add(
      addMorePaginationBtn(
          onTap: () {
            _resultsController.loadMoreMoviesResults(resultType: resultType);
          },
          viewState: state.value),
    );

    return items;
  }

  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title & more option
        headerTile(
          onMoreTap: () {
            Get.toNamed('/movie_results_list', arguments: {
              "title": '$title $subtitle',
              "movies": getItem(resultType)
            });
          },
          title: title ?? "title",
          subtitle: subtitle ?? "subtitle",
        ),

        const SizedBox(height: 12),

        // horizontal scroll view
        Container(
          // color: primaryblue,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(children: moviesList(getItem(resultType) ?? [])),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
