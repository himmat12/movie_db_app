import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/global/tv_thumbnail_card.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/avatar.dart';

class HomeTrendingTvList extends StatelessWidget with AvatarBuilderMixin {
  final Widget? toggleOption;
  final String? title;

  final _configurationController = Get.find<ConfigurationController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();

  HomeTrendingTvList({
    Key? key,
    this.toggleOption,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 28),
            Obx(
              () => WidgetBuilderHelper(
                state: _trendingResultsController.tvViewState,
                onLoadingBuilder: LoadingSpinner.fadingCircleSpinner,
                onSuccessBuilder: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _trendingResultsController.trendingTVs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 186,
                  ),
                  itemBuilder: (context, index) => tvThumbnailCard(
                    padding: const EdgeInsets.all(0),
                    tv: _trendingResultsController.trendingTVs[index],
                    imageUrl:
                        '${_configurationController.posterUrl}${_trendingResultsController.trendingTVs[index].posterPath}',
                  ),
                ),
                onErrorBuilder: const Center(
                  child: Text('error while loading data ...'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
