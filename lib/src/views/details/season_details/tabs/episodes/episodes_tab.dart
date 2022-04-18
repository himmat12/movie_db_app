import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../configs/configs.dart';
import '../../../../../controllers/configuration_controller.dart';
import '../../../../../controllers/details_controller.dart';
import '../../../../../controllers/season_controller.dart';
import '../../../../../mixins/avatar.dart';
import '../../../../../models/details/season_details_model.dart';

class EpisodesTab extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();
  final _seasonController = Get.find<SeasonController>();

  EpisodesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // total seasons/episodes
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Text(
            '${_seasonController.seasonModel.value.episodes == null ? 0 : _seasonController.seasonModel.value.episodes!.length} Episodes',
            style: TextStyle(
              color: primaryDarkBlue.withOpacity(0.7),
              fontSize: n,
            ),
          ),
        ),
        ListView.separated(
          itemCount: _seasonController.seasonModel.value.episodes == null
              ? 0
              : _seasonController.seasonModel.value.episodes!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            Episode episode =
                _seasonController.seasonModel.value.episodes![index];

            final String? airDate =
                DateFormat.yMMMMd().format(episode.airDate ?? DateTime(0000));

            return InkWell(
              onTap: () {
                _seasonController
                    .setTvId(_detailsController.tvDetail.value.id ?? 0);
                _seasonController.setSeasonNo(episode.seasonNumber ?? 0);
                _seasonController.setEpisodeNo(episode.episodeNumber ?? 0);

                Get.toNamed('/episode_details', preventDuplicates: false);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        //  episode still image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: episode.stillPath == null
                              ? _detailsController
                                              .tvDetail.value.backdropPath ==
                                          null ||
                                      _detailsController
                                              .tvDetail.value.backdropPath ==
                                          ""
                                  ? Container(
                                      alignment: Alignment.center,
                                      width: 90,
                                      height: 64,
                                      color: Colors.black12,
                                      child: const Icon(
                                        Icons.error_outline,
                                        color: primaryWhite,
                                        size: 34,
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      width: 90,
                                      height: 64,
                                      imageUrl:
                                          '${_configurationController.backDropUrl}${_detailsController.tvDetail.value.backdropPath}',
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
                                  width: 90,
                                  height: 64,
                                  imageUrl:
                                      '${_configurationController.stillUrl}${episode.stillPath}',
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
                                ),
                        ),

                        //  episode floating watermark badge
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: primaryDarkBlue.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'EP-${episode.episodeNumber ?? ''}',
                              style: const TextStyle(
                                color: primaryWhite,
                                fontSize: n - 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 18),

                    // episode titles and data
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            episode.name ?? "title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: m - 4,
                              color: primaryDarkBlue.withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${airDate ?? 0}',
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
