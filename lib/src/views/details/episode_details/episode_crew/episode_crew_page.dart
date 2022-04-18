import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../controllers/configuration_controller.dart';
import '../../../../controllers/details_controller.dart';
import '../../../../controllers/people_controller.dart';
import '../../../../controllers/season_controller.dart';
import '../../../../mixins/avatar.dart';
import '../../../../models/details/season_details_model.dart';

class EpisodeCrewPage extends StatelessWidget with AvatarBuilderMixin {
  EpisodeCrewPage({
    required this.seasonNumber,
    Key? key,
  }) : super(key: key);

  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();

  final _peopleController = Get.find<PeopleController>();
  final _seasonController = Get.find<SeasonController>();

  final String seasonNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Featured Crew - ${_seasonController.episodeModel.value.name}'),
              Text(
                '${_detailsController.tvDetail.value.name} [S${seasonNumber.padLeft(2, '0')} | E${_seasonController.episodeModel.value.episodeNumber.toString().padLeft(2, '0')}]',
                style: TextStyle(
                  fontSize: n,
                  color: primaryDarkBlue.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _seasonController.episodeModel.value.crew == null ||
                    _seasonController.episodeModel.value.crew!.isEmpty
                ? SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        'No Crews To Feature at the Moment',
                        style:
                            TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18),
                        child: Text(
                          '${_seasonController.episodeModel.value.crew == null ? 0 : _seasonController.episodeModel.value.crew!.length} Persons',
                          style: TextStyle(
                            color: primaryDarkBlue.withOpacity(0.7),
                            fontSize: n,
                          ),
                        ),
                      ),
                      ListView.separated(
                        itemCount: _seasonController.episodeModel.value.crew ==
                                null
                            ? 0
                            : _seasonController.episodeModel.value.crew!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          SeasonCrew crew =
                              _seasonController.episodeModel.value.crew![index];

                          return InkWell(
                            onTap: () {
                              _peopleController.setPersonId(crew.id!);
                              Get.toNamed('/people_details');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: crew.profilePath == null
                                        ? avatarBuilder()
                                        : CachedNetworkImage(
                                            height: 68,
                                            width: 68,
                                            imageUrl:
                                                '${_configurationController.posterUrl}${crew.profilePath}',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                    color: Colors.black26),
                                            errorWidget:
                                                (context, url, error) =>
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
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          crew.name ?? "name",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: m - 4,
                                            color: primaryDarkBlue
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          crew.job ?? "job",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: n - 2,
                                            color: primaryDarkBlue
                                                .withOpacity(0.6),
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
                      const SizedBox(height: 80),
                    ],
                  ),
          ),
        ));
  }
}
