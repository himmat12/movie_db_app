import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/models/details/season_details_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget episodeFlexibleSpacebarComponent({
  required Episode episode,
  double? height,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _configController = Get.find<ConfigurationController>();

  final _seasonController = Get.find<SeasonController>();

  final String? firstAirDate =
      DateFormat.yMMMMd().format(episode.airDate ?? DateTime(0000));

  String seasonNo = _seasonController.seasonModel.value.seasonNumber
      .toString()
      .padLeft(2, '0');
  String episodeNo = _seasonController.episodeModel.value.episodeNumber
      .toString()
      .padLeft(2, '0');

  return GetBuilder(
    id: 'season_details',
    init: _seasonController,
    initState: (_) {},
    builder: (controller) => SizedBox(
      // height: _utilityController.titlevisiblity == false ? 330 : 300,
      height: 340,
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
                  state: _seasonController.episodeState,
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
                          itemCount: _seasonController
                                      .episodeModel.value.images!.stills ==
                                  null
                              ? 0
                              : _seasonController
                                  .episodeModel.value.images!.stills!.length,
                          controller: PageController(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  '${_configController.stillUrl}${_seasonController.episodeModel.value.images!.stills![index].filePath}',
                              errorWidget: (context, url, error) => Container(
                                alignment: Alignment.center,
                                // width: 94,
                                // height: 140,
                                color: Colors.black12,
                                child: const Icon(
                                  Icons.error_outline,
                                  color: primaryWhite,
                                  size: 34,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // ),
                _seasonController.episodeModel.value.images!.stills == null ||
                        _seasonController
                            .episodeModel.value.images!.stills!.isEmpty
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
                            count: _seasonController
                                .episodeModel.value.images!.stills!.length,
                          ),
                        ),
                      ),
              ],
            ),
          ),

          // poster and title tv details
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                /// episode titles
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'S$seasonNo | E$episodeNo',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: m,
                                fontWeight: FontWeight.bold,
                                color: primaryDarkBlue,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // _utilityController.toggleTitleVisibility();
                              },
                              child: Obx(
                                () => _utilityController.titlevisiblity == false
                                    ? Text(
                                        episode.name ?? 'episode name',
                                        style: const TextStyle(
                                          fontSize: m,
                                          fontWeight: FontWeight.bold,
                                          color: primaryDarkBlue,
                                        ),
                                      )
                                    : Text(
                                        episode.name ?? 'episode name',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: m,
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
                                  firstAirDate!,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                /// user votes & cote counts
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // user score %
                      Row(
                        children: [
                          _seasonController.episodeModel.value.voteAverage ==
                                  null
                              ? const SizedBox.shrink()
                              : CircularPercentIndicator(
                                  radius: 56,
                                  percent: (_seasonController
                                          .episodeModel.value.voteAverage! /
                                      10),
                                  curve: Curves.ease,
                                  animation: true,
                                  animationDuration: 800,
                                  progressColor: primaryblue,
                                  center: Text(
                                    '${(_seasonController.episodeModel.value.voteAverage! * 10).toInt()}%',
                                    style: const TextStyle(
                                      color: primaryDarkBlue,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 4),
                          const Text(
                            'User\nScore',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: n - 2,
                              fontWeight: FontWeight.w700,
                              color: primaryDarkBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 18),
                      // vote counts
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          // height: 46,
                          // width: 46,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryDarkBlue.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_seasonController.episodeModel.value.voteCount}',
                            style: const TextStyle(
                              fontSize: l - 2,
                              color: primaryWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Vote\nCounts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: n - 2,
                            fontWeight: FontWeight.w700,
                            color: primaryDarkBlue,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
