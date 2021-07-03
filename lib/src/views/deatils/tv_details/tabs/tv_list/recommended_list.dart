import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/tv_list/tv_list.dart';

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
