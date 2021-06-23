import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/models/details/season_details_model.dart';

Widget seasonFlexibleSpacebarComponent({
  required SeasonModel season,
  double? height,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _configController = Get.find<ConfigurationController>();
  final _detailsController = Get.find<DetailsController>();
  final _resultController = Get.find<ResultsController>();
  final _seasonController = Get.find<SeasonController>();

  final String? firstAirDate =
      DateFormat.yMMMMd().format(season.airDate ?? DateTime(0000));

  return GetBuilder(
    id: 'season_details',
    init: _seasonController,
    initState: (_) {},
    builder: (controller) => SizedBox(
      height: _utilityController.titlevisiblity == false ? 310 : 300,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // backdrop image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ShaderMask(
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
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.transparent)),
                ),
                child: SizedBox(
                  height: height ?? 190,
                  child: _detailsController.images.value.backdrops == null
                      ? const SizedBox.shrink()
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              '${_configController.backDropUrl}${_detailsController.images.value.backdrops![0].filePath}',
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
                        ),
                ),
              ),
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
                    child: season.posterPath == null
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
                            imageUrl:
                                '${_configController.posterUrl}${season.posterPath}',
                            placeholder: (context, url) => Container(
                              color: Colors.black12,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  //  titles
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _utilityController.toggleTitleVisibility();
                          },
                          child: Obx(
                            () => _utilityController.titlevisiblity == false
                                ? Text(
                                    season.name ?? 'season name',
                                    style: const TextStyle(
                                      fontSize: m - 2,
                                      fontWeight: FontWeight.bold,
                                      color: primaryDarkBlue,
                                    ),
                                  )
                                : Text(
                                    season.name ?? 'season name',
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
                              firstAirDate!,
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
                              '${season.episodes!.length} Episodes',
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
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
