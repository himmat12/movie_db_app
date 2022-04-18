import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/strings.dart';
import '../../../../controllers/configuration_controller.dart';
import '../../../../controllers/trending_results_controller.dart';
import '../../../../controllers/utility_controller.dart';
import '../../../../global/loading_spinner.dart';
import '../../../../global/tv_thumbnail_card.dart';
import '../../../../helpers/widget_builder_helper.dart';
import '../../../../mixins/avatar.dart';

class HomeTrendingTvList extends StatelessWidget with AvatarBuilderMixin {
  final Widget? toggleOption;
  final String? title;

  final _configurationController = Get.find<ConfigurationController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _utilityController = Get.find<UtilityController>();

  HomeTrendingTvList({
    Key? key,
    this.toggleOption,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // initializing trending TV services
        if (_utilityController.isTvToday == true) {
          _trendingResultsController.getTrendingTvResults(
              timeWindow: dayString, page: '1');
        } else {
          _trendingResultsController.getTrendingTvResults(
              timeWindow: weekString, page: '1');
        }
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Row(
            children: [
              Text(title ?? 'title'),
              const SizedBox(width: 8),
              toggleOption ?? const SizedBox.shrink(),
            ],
          ),
        ),
        body: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              _trendingResultsController.loadMoreTrendingTvResults(
                  timeWindow: _utilityController.isTvToday == true
                      ? dayString
                      : weekString);
            }
            return false;
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 28),
                GetBuilder(
                  id: 'trending_tv_list',
                  init: _trendingResultsController,
                  builder: (controller) {
                    return WidgetBuilderHelper(
                      state: _trendingResultsController.tvViewState,
                      onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
                      onSuccessBuilder: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            _trendingResultsController.trendingTVs.length,
                        semanticChildCount:
                            _trendingResultsController.trendingTVs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 186,
                        ),
                        itemBuilder: (context, index) => AbsorbPointer(
                          absorbing: _trendingResultsController
                                          .trendingTVs[index].posterPath !=
                                      null ||
                                  _trendingResultsController
                                          .trendingTVs[index].posterPath !=
                                      ""
                              ? false
                              : true,
                          child: tvThumbnailCard(
                            padding: const EdgeInsets.all(0),
                            tv: _trendingResultsController.trendingTVs[index],
                            imageUrl:
                                '${_configurationController.posterUrl}${_trendingResultsController.trendingTVs[index].posterPath}',
                          ),
                        ),
                      ),
                      onErrorBuilder: const Center(
                        child: Text('error while loading data ...'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
