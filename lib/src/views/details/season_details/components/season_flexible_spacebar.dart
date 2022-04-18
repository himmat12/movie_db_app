import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../configs/configs.dart';
import '../../../../controllers/configuration_controller.dart';
import '../../../../controllers/details_controller.dart';
import '../../../../controllers/season_controller.dart';
import '../../../../controllers/utility_controller.dart';
import '../../../../models/details/season_details_model.dart';
import '../../components/backdrop_card.dart';
import '../../components/poster_card.dart';

Widget seasonFlexibleSpacebarComponent({
  required SeasonModel season,
  double? height,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _configController = Get.find<ConfigurationController>();
  final _detailsController = Get.find<DetailsController>();
  final _seasonController = Get.find<SeasonController>();

  final String? firstAirDate =
      DateFormat.yMMMMd().format(season.airDate ?? DateTime(0000));

  return GetBuilder(
    id: 'season_details',
    init: _seasonController,
    initState: (_) {},
    builder: (controller) => SizedBox(
      // height: _utilityController.titlevisiblity == false ? 310 : 300,
      height: 310,
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
                  child: _detailsController.images.value.backdrops == null ||
                          _detailsController.images.value.backdrops!.isEmpty
                      ? const SizedBox.shrink()
                      : BackdropCard(
                          imageUrl:
                              '${_configController.backDropUrl}${_detailsController.images.value.backdrops![0].filePath}'),
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
                          : posterCard(
                              imageUrl:
                                  '${_configController.posterUrl}${season.posterPath}')),

                  const SizedBox(width: 16),
                  //  titles
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _utilityController.toggleTitleVisibility();
                          },
                          child: Obx(
                            () => _utilityController.titlevisiblity == false
                                ? Text(
                                    season.name ?? 'season name',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
