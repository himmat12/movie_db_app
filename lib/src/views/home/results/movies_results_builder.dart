import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/strings.dart';
import '../../../controllers/base_controller.dart';
import '../../../controllers/results_controller.dart';
import '../../../global/add_more_pagination_btn.dart';
import '../../../global/movie_thumbnail_card.dart';
import '../../../models/results/movie_result_model.dart';
import '../components/header_tile.dart';

class MovieResultBuilder extends GetView<ResultsController> {
  const MovieResultBuilder(
      {required this.resultType,
      required this.posterUrl,
      required this.state,
      this.onMoreTap,
      this.subtitle,
      this.title,
      this.trailingBtn,
      Key? key})
      : super(key: key);
  final String resultType;
  final String posterUrl;
  final Rx<ViewState> state;
  final String? title;
  final String? subtitle;
  final Widget? trailingBtn;
  final void Function()? onMoreTap;

// returns respected movies list according to the given resultType parameter
  RxList<MovieResultModel>? getItem(String resultType) {
    switch (resultType) {
      case popularString:
        return controller.popularMovies;
      case topRatedString:
        return controller.topRatedMovies;
      case upcomingString:
        return controller.upcommingMovies;
      case nowPlayingString:
        return controller.nowPlayingMovies;
      default:
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title & more option
          HeaderTile(
            onMoreTap: () {
              controller.getMovieResults(resultType: resultType, page: '1');
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
                                  child: MovieThumbnailCard(
                                      movie: getItem(resultType)![index],
                                      imageUrl:
                                          '$posterUrl${getItem(resultType)![index].posterPath}'),
                                )
                              : MovieThumbnailCard(
                                  movie: getItem(resultType)![index],
                                  imageUrl:
                                      '$posterUrl${getItem(resultType)![index].posterPath}')),
                      AddMorePaginationBtn(
                          onTap: () {
                            controller.loadMoreMoviesResults(
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
}
