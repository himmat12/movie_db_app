import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/configs.dart';
import '../../../../../configs/strings.dart';
import '../../../../../controllers/details_controller.dart';
import '../../../../../controllers/results_controller.dart';
import '../../../../../global/loading_spinner.dart';
import '../../../../../helpers/widget_builder_helper.dart';
import 'tv_list.dart';

class TvRecommendedTab extends StatelessWidget {
  TvRecommendedTab({Key? key}) : super(key: key);

  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'tv_recommended',
      init: _detailsController,
      initState: (_) {
        _detailsController.getOtherDetails(
            resultType: tvString,
            id: _resultsController.tvId,
            appendTo: recommendedSTring);
      },
      builder: (controller) => WidgetBuilderHelper(
        state: _detailsController.recommendedState.value,
        onLoadingBuilder: LoadingSpinner().fadingCircleSpinner,
        onErrorBuilder: const Center(
          child: Text('error while loading data ...'),
        ),
        onSuccessBuilder: _detailsController.recommendedTv.value.results ==
                    null ||
                _detailsController.recommendedTv.value.results!.isEmpty
            ? SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    'No Recommended TV Series at the Moment',
                    style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                  ),
                ),
              )
            : Column(
                children: [
                  TvList(
                      tv: _detailsController.recommendedTv.value.results ?? []),
                ],
              ),
      ),
    );
  }
}
