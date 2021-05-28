import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global_components/more_btn.dart';
import 'package:movie_app/src/global_components/switch_btn.dart';
import 'package:movie_app/src/models/movie_result_model.dart';
import 'package:movie_app/src/models/tv_result_model.dart';

Widget tvBlockBuilder({
  String? title,
  required String posterUrl,
  void Function()? onMoreTap,
}) {
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _utilityController = Get.find<UtilityController>();

  var items = <Widget>[];

// returns listview items
  List<Widget> tvsList(List<TvResultModel> tvs) {
    items = List.from(tvs.map((e) => GestureDetector(
          onTap: () {
            // ignore: avoid_print
            print('navigating to movie details page ...');
          },
          child: SizedBox(
            width: 100,
            height: 184,
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
                          e.name ?? "Title",
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
        _trendingResultsController.loadMoreTrendingTvResults(
            timeWindow: _utilityController.isTvToday == true
                ? DAY_STRING
                : WEEK_STRING);
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
                child: _trendingResultsController.tvViewState == ViewState.busy
                    ? const CircularProgressIndicator(color: secondaryDarkBlue)
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
                    style: const TextStyle(fontSize: m),
                  ),
                  const SizedBox(width: 6),
                  tvSwitchBtnBuilder(
                    text1: "Today",
                    text2: "This Week",
                  ),
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
              () => Row(
                  children: tvsList(_trendingResultsController.trendingTVs)),
            ),
          ),
        ),
      ],
    ),
  );
}
