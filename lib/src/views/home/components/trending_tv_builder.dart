import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/add_more_pagination_btn.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/global/more_btn.dart';
import 'package:movie_app/src/global/switch_btn.dart';
import 'package:movie_app/src/global/tv_thumbnail_card.dart';
import 'package:movie_app/src/models/results/tv_result_model.dart';
import 'package:movie_app/src/views/home/components/header_tile.dart';

Widget trendingTvBuilder({
  required String posterUrl,
}) {
  // ignore: avoid_print
  print("trending tv builder builded");

  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _utilityController = Get.find<UtilityController>();

  var items = <Widget>[];

// returns listview items
  List<Widget> tvsList(List<TvResultsModel> tvs) {
    items = List.from(
      tvs.map(
          (e) => tvThumbnailCard(tv: e, imageUrl: "$posterUrl${e.posterPath}")),
    );

    // load more option
    items.add(
      addMorePaginationBtn(
          onTap: () {
            _trendingResultsController.loadMoreTrendingTvResults(
                timeWindow: _utilityController.isTvToday == true
                    ? DAY_STRING
                    : WEEK_STRING);
          },
          viewState: _trendingResultsController.tvViewState),
    );

    return items;
  }

  return SizedBox(
    child: Column(
      children: [
        // title & more option
        headerTile(
          onMoreTap: () {
            // navigate to tv lists page
          },
          title: "Trending",
          subtitle: "TV Series",
          toggleOption: trendingTvSwitchBtnBuilder(),
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
                child: Row(
                    children: tvsList(_trendingResultsController.trendingTVs)),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
