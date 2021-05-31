import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global_components/loading_spinner.dart';
import 'package:movie_app/src/global_components/more_btn.dart';
import 'package:movie_app/src/models/movie_result_model.dart';

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
  print("$resultType movie builder builded");

  final _resultsController = Get.find<ResultsController>();

  var items = <Widget>[];

// returns respected movies list according to the given resultType parameter
  RxList<MovieResultModel>? getItem(String resultType) {
    switch (resultType) {
      case POPULAR_STRING:
        return _resultsController.popularMovies;
      case TOP_RATED_STRING:
        return _resultsController.topRatedMovies;
      case UPCOMING_STRING:
        return _resultsController.upcommingMovies;
      case NOW_PLAYING_STRING:
        return _resultsController.nowPlayingMovies;
      default:
        break;
    }
  }

// returns listview items
  List<Widget> moviesList(List<MovieResultModel> movies) {
    items = List.from(movies.map((e) => GestureDetector(
          onTap: () {
            // ignore: avoid_print
            print('navigating to movie details page ...');
          },
          child: SizedBox(
            width: 100,
            height: 186,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: e.posterPath == null
                            ? Container(
                                alignment: Alignment.center,
                                width: 94,
                                height: 140,
                                color: Colors.black12,
                                child: const Icon(
                                  Icons.error_outline,
                                  color: primaryWhite,
                                  size: 34,
                                ),
                              )
                            : CachedNetworkImage(
                                width: 94,
                                height: 140,
                                fit: BoxFit.fill,
                                imageUrl: "$posterUrl${e.posterPath}",
                                placeholder: (context, url) => Container(
                                  color: Colors.black12,
                                ),
                              ),
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                          decoration: BoxDecoration(
                            color: primaryDark.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${e.voteAverage}',
                            style: const TextStyle(
                              fontSize: n - 5,
                              color: primaryWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // movie title and option
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          e.title ?? "Title",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: n - 5,
                            fontWeight: FontWeight.w600,
                            // letterSpacing: 0.2,
                            color: primaryDark,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // ignore: avoid_print
                          print('options bottom sheet ...');
                        },
                        child: const Icon(
                          Icons.more_vert,
                          color: primaryDarkBlue,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));

    // load more option
    items.add(GestureDetector(
      onTap: () {
        _resultsController.loadMoreMoviesResults(resultType: resultType);
        // ignore: avoid_print
        // print('add more pages');
      },
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 88,
                height: 140,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Center(
                child: state.value == ViewState.busy
                    ? LoadingSpinner.fadingCircleSpinner
                    : const Icon(
                        Icons.add,
                        size: 34,
                        color: primaryWhite,
                      ),
              )
            ],
          ),
          const Text("\n"), //for spacing to match with other cards
        ],
      ),
    ));

    return items;
  }

  return SizedBox(
    child: Column(
      children: [
        // title & more option
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title ?? 'title',
                    style: const TextStyle(fontSize: m - 2),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    subtitle ?? 'subtitle',
                    style: const TextStyle(
                      fontSize: m - 4,
                      color: primaryblue,
                    ),
                  ),
                  const SizedBox(width: 6),
                  trailingBtn ?? const SizedBox.shrink(),
                ],
              ),
              moreBtn(onTap: onMoreTap ?? () {}),
            ],
          ),
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
