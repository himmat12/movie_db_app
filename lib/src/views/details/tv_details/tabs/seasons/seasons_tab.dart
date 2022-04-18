import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/configs.dart';
import '../../../../../controllers/configuration_controller.dart';
import '../../../../../controllers/details_controller.dart';
import '../../../../../controllers/season_controller.dart';
import '../../../../../mixins/avatar.dart';
import '../../../../../models/details/tv_details_model.dart';

class SeasonsTab extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();
  final _seasonController = Get.find<SeasonController>();

  SeasonsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // total seasons/episodes
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_detailsController.tvDetail.value.seasons == null ? 0 : _detailsController.tvDetail.value.seasons!.length} Seasons',
                style: TextStyle(
                  color: primaryDarkBlue.withOpacity(0.7),
                  fontSize: n,
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
                '${_detailsController.tvDetail.value.seasons == null ? 0 : _detailsController.tvDetail.value.numberOfEpisodes} Episodes',
                style: TextStyle(
                  color: primaryDarkBlue.withOpacity(0.7),
                  fontSize: n,
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          itemCount: _detailsController.tvDetail.value.seasons == null
              ? 0
              : _detailsController.tvDetail.value.seasons!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            Season season = _detailsController.tvDetail.value.seasons![index];

            return InkWell(
              onTap: () {
                _seasonController
                    .setTvId(_detailsController.tvDetail.value.id ?? 0);
                _seasonController.setSeasonNo(season.seasonNumber ?? 0);

                Get.toNamed('/season_details', preventDuplicates: false);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: season.posterPath == null
                          ? _detailsController.tvDetail.value.posterPath == null
                              ? Container(
                                  alignment: Alignment.center,
                                  width: 64,
                                  height: 90,
                                  color: Colors.black12,
                                  child: const Icon(
                                    Icons.error_outline,
                                    color: primaryWhite,
                                    size: 34,
                                  ),
                                )
                              : CachedNetworkImage(
                                  width: 64,
                                  height: 90,
                                  imageUrl:
                                      '${_configurationController.posterUrl}${_detailsController.tvDetail.value.posterPath}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Container(color: Colors.black26),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.black38,
                                    child: const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: primaryWhite,
                                        size: 34,
                                      ),
                                    ),
                                  ),
                                )
                          : CachedNetworkImage(
                              width: 64,
                              height: 90,
                              imageUrl:
                                  '${_configurationController.posterUrl}${season.posterPath}',
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container(color: Colors.black26),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.black38,
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: primaryWhite,
                                    size: 34,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            season.name ?? "title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: m - 4,
                              color: primaryDarkBlue.withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${season.episodeCount ?? 0} Episodes',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: n - 2,
                              color: primaryDarkBlue.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
