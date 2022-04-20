import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/strings.dart';
import '../../../../controllers/base_controller.dart';
import '../../../../controllers/configuration_controller.dart';
import '../../../../controllers/results_controller.dart';
import '../../../../global/loading_spinner.dart';
import '../../../../global/tv_thumbnail_card.dart';
import '../../../../helpers/widget_builder_helper.dart';
import '../../../../mixins/loading_spinner_mixin.dart';
import '../../../../models/results/tv_result_model.dart';

class HomeTvResultList extends StatelessWidget with LoadingSpinnerMixin {
  // final List<TvResultsModel> tv;
  final String? title;
  final String resultType;
  final Rx<ViewState> state;

  HomeTvResultList({
    required this.state,
    required this.resultType,
    Key? key,
    // required this.tv,
    this.title,
  }) : super(key: key);

  final _configurationController = Get.find<ConfigurationController>();
  final _resultsController = Get.find<ResultsController>();

// returns respected movies list according to the given resultType parameter
  List<TvResultsModel>? getItem(String resultType) {
    switch (resultType) {
      case popularString:
        return _resultsController.popularTvList;
      case topRatedString:
        return _resultsController.topRatedTvList;
      case airingTodayString:
        return _resultsController.airingTodayTvList;
      case onTheAirString:
        return _resultsController.onTheAirTvList;
      default:
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _resultsController.getTvResults(resultType: resultType, page: '1');
        Get.back();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? 'title'),
          elevation: 0.5,
        ),
        body: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              _resultsController.loadMoreTvResults(resultType: resultType);
            }
            return false;
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 28),
                GetBuilder(
                  id: 'tv_result',
                  init: _resultsController,
                  builder: (controller) {
                    return WidgetBuilderHelper(
                      state: state.value,
                      onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
                      onSuccessBuilder: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        semanticChildCount: getItem(resultType) == null
                            ? 0
                            : getItem(resultType)!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 186,
                        ),
                        itemBuilder: (context, index) => AbsorbPointer(
                          absorbing: getItem(resultType)![index].posterPath !=
                                      null ||
                                  getItem(resultType)![index].posterPath != ""
                              ? false
                              : true,
                          child: TvThumbnailCard(
                            padding: const EdgeInsets.all(0),
                            tv: getItem(resultType)![index],
                            imageUrl:
                                '${_configurationController.posterUrl}${getItem(resultType)![index].posterPath}',
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
