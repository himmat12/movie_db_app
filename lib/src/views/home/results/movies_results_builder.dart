import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/strings.dart';
import '../../../controllers/base_controller.dart';
import '../../../controllers/results_controller.dart';
import '../../../global/add_more_pagination_btn.dart';
import '../../../global/movie_thumbnail_card.dart';
import '../../../models/results/movie_result_model.dart';
import '../components/header_tile.dart';

Widget movieResultBuilder({
  required String resultType,
  required String posterUrl,
  required Rx<ViewState> state,
  String? title,
  String? subtitle,
  Widget? trailingBtn,
  void Function()? onMoreTap,
}) {
  // ignore: avoid_print
  // print("$resultType movie builder builded");

  final _resultsController = Get.find<ResultsController>();

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
    return null;
  }

  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title & more option
        headerTile(
          onMoreTap: () {
            _resultsController.getMovieResults(
                resultType: resultType, page: '1');
            Get.toNamed('/movie_results_list', arguments: {
              "state": state,
              "title": '$title $subtitle',
              "resultType": resultType
            });
          },
          title: title ?? "title",
          subtitle: subtitle ?? "subtitle",
        ),

        const SizedBox(height: 12),

        // horizontal scroll view

        Container(
          // color: primaryblue,
          height: 200,
          width: MediaQuery.of(Get.context!).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  children: [
                    ListView.builder(
                        itemExtent: 96,
                        cacheExtent: 1200,
                        semanticChildCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        itemCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => getItem(
                                            resultType)![index]
                                        .posterPath ==
                                    null ||
                                getItem(resultType)![index].posterPath == ""
                            ? AbsorbPointer(
                                absorbing: true,
                                child: movieThumbnailCard(
                                    movie: getItem(resultType)![index],
                                    imageUrl:
                                        '$posterUrl${getItem(resultType)![index].posterPath}'),
                              )
                            : movieThumbnailCard(
                                movie: getItem(resultType)![index],
                                imageUrl:
                                    '$posterUrl${getItem(resultType)![index].posterPath}')),
                    addMorePaginationBtn(
                        onTap: () {
                          _resultsController.loadMoreMoviesResults(
                              resultType: resultType);
                        },
                        viewState: state.value),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
