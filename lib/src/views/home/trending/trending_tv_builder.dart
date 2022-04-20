import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/strings.dart';
import '../../../controllers/trending_results_controller.dart';
import '../../../controllers/utility_controller.dart';
import '../../../global/add_more_pagination_btn.dart';
import '../../../global/switch_btn.dart';
import '../../../global/tv_thumbnail_card.dart';
import '../components/header_tile.dart';

class TrendingTvBuilder extends StatelessWidget {
  TrendingTvBuilder({required this.posterUrl, Key? key}) : super(key: key);

  final String posterUrl;

  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title & more option
          headerTile(
            onMoreTap: () {
              // initializing trending TV services
              if (_utilityController.isTvToday == true) {
                _trendingResultsController.getTrendingTvResults(
                    timeWindow: dayString, page: '1');
              } else {
                _trendingResultsController.getTrendingTvResults(
                    timeWindow: weekString, page: '1');
              }
              Get.toNamed('/trending_tv_list', arguments: {
                "title": "Trending TV",
                "toggleOption": TrendingTvSwitchBtnBuilder()
              });
            },
            title: "Trending",
            subtitle: "TV Series",
            toggleOption: TrendingTvSwitchBtnBuilder(),
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
                          semanticChildCount:
                              _trendingResultsController.trendingTVs.length,
                          itemCount:
                              _trendingResultsController.trendingTVs.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              _trendingResultsController
                                              .trendingTVs[index].posterPath ==
                                          null ||
                                      _trendingResultsController
                                              .trendingTVs[index].posterPath ==
                                          ""
                                  ? AbsorbPointer(
                                      absorbing: true,
                                      child: TvThumbnailCard(
                                          tv: _trendingResultsController
                                              .trendingTVs[index],
                                          imageUrl:
                                              '$posterUrl${_trendingResultsController.trendingTVs[index].posterPath}'),
                                    )
                                  : TvThumbnailCard(
                                      tv: _trendingResultsController
                                          .trendingTVs[index],
                                      imageUrl:
                                          '$posterUrl${_trendingResultsController.trendingTVs[index].posterPath}')),
                      AddMorePaginationBtn(
                          onTap: () {
                            _trendingResultsController
                                .loadMoreTrendingTvResults(
                                    timeWindow:
                                        _utilityController.isTvToday == true
                                            ? dayString
                                            : weekString);
                          },
                          viewState: _trendingResultsController.tvViewState),
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
