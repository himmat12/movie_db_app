import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../configs/configs.dart';
import '../../../../configs/strings.dart';
import '../../../../controllers/configuration_controller.dart';
import '../../../../controllers/details_controller.dart';
import '../../../../controllers/results_controller.dart';
import '../../../../controllers/utility_controller.dart';
import '../../../../global/loading_spinner.dart';
import '../../../../helpers/widget_builder_helper.dart';
import '../../../../models/details/tv_details_model.dart';
import '../../components/backdrop_card.dart';
import '../../components/poster_card.dart';

Widget tvFlexibleSpacebarComponent({
  required TvDetailsModel tv,
  double? height,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _configController = Get.find<ConfigurationController>();
  final _detailsController = Get.find<DetailsController>();
  final _resultController = Get.find<ResultsController>();

  final String? releaseDate = '${tv.firstAirDate}';
  final String? formatedDate =
      DateFormat.yMMMMd().format(tv.firstAirDate ?? DateTime(0000));
  final String tvDate = releaseDate!.substring(0, 4);
  return GetBuilder(
    id: 'imageSlider',
    init: _detailsController,
    initState: (_) {
      _detailsController.getOtherDetails(
          resultType: tvString,
          id: _resultController.tvId,
          appendTo: imagesString);
    },
    builder: (controller) => SizedBox(
      // height: _utilityController.titlevisiblity == false ? 310 : 300,
      height: 310,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // backdrop image slider
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                // Obx(
                //   () =>
                WidgetBuilderHelper(
                  state: _detailsController.imagesState.value,
                  onLoadingBuilder: SizedBox(
                    height: 200,
                    child: LoadingSpinner().fadingCircleSpinner,
                  ),
                  onErrorBuilder: const Center(
                    child: Text('error while initializing data...'),
                  ),
                  onSuccessBuilder: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.transparent
                        ],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.transparent)),
                      ),
                      child: SizedBox(
                        height: height ?? 190,
                        child: PageView.builder(
                          onPageChanged: (value) {
                            _utilityController.setSliderIndex(value);
                          },
                          itemCount:
                              _detailsController.images.value.backdrops ==
                                          null ||
                                      _detailsController
                                          .images.value.backdrops!.isEmpty
                                  ? 0
                                  : _detailsController
                                      .images.value.backdrops!.length,
                          controller: PageController(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return BackdropCard(
                                imageUrl:
                                    '${_configController.backDropUrl}${_detailsController.images.value.backdrops![index].filePath}');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // ),

                // img slider indicator
                _detailsController.images.value.backdrops == null ||
                        _detailsController.images.value.backdrops!.isEmpty
                    ? const SizedBox.shrink()
                    : GetBuilder(
                        id: 'imageSlider',
                        init: _utilityController,
                        builder: (controller) => Positioned(
                          bottom: 16,
                          child: AnimatedSmoothIndicator(
                            activeIndex: _utilityController.imgSliderIndex,
                            effect: const ScrollingDotsEffect(
                              activeDotColor: primaryDarkBlue,
                              dotColor: primaryblue,
                              dotHeight: 6,
                              dotWidth: 6,
                            ),
                            count: _detailsController
                                .images.value.backdrops!.length,
                          ),
                        ),
                      ),
              ],
            ),
          ),

          // poster and title tv details
          Positioned(
            bottom: 0.0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  // poster
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: tv.posterPath == null
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
                          : PosterCard(
                              imageUrl:
                                  '${_configController.posterUrl}${tv.posterPath}')),
                  const SizedBox(width: 16),
                  //  titles
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            tv.status == null
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: primaryDark.withOpacity(0.5),
                                          width: 1,
                                        ),
                                        left: BorderSide(
                                          color: primaryDark.withOpacity(0.5),
                                          width: 1,
                                        ),
                                        right: BorderSide(
                                          color: primaryDark.withOpacity(0.5),
                                          width: 1,
                                        ),
                                        bottom: BorderSide(
                                          color: primaryDark.withOpacity(0.5),
                                          width: 1,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _detailsController.tvDetail.value.status!,
                                      style: TextStyle(
                                        fontSize: n - 4,
                                        color: primaryDarkBlue.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            // _utilityController.toggleTitleVisibility();
                          },
                          child: Obx(
                            () => _utilityController.titlevisiblity == false
                                ? Text(
                                    '${tv.name} ($tvDate)',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: m - 2,
                                      fontWeight: FontWeight.bold,
                                      color: primaryDarkBlue,
                                    ),
                                  )
                                : Text(
                                    '${tv.name} ($tvDate)',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: m - 2,
                                      fontWeight: FontWeight.bold,
                                      color: primaryDarkBlue,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Wrap(
                          children: [
                            Text(
                              formatedDate!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: n - 2,
                                fontWeight: FontWeight.bold,
                                color: primaryDarkBlue.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '•',
                              style: TextStyle(
                                fontSize: n - 2,
                                color: primaryDarkBlue.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${tv.episodeRunTime} mins',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: n - 2,
                                fontWeight: FontWeight.bold,
                                color: primaryDarkBlue.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                _detailsController.tvDetail.value.tagline ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: n - 2,
                                  fontStyle: FontStyle.italic,
                                  color: primaryDarkBlue.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
