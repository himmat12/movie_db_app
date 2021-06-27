import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/details/season_details_model.dart';

class GuestStarsList extends StatelessWidget with AvatarBuilderMixin {
  GuestStarsList({Key? key}) : super(key: key);

  final _configurationController = Get.find<ConfigurationController>();
  final _detailsController = Get.find<DetailsController>();
  final _seasonController = Get.find<SeasonController>();
  final _peopleController = Get.find<PeopleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Guest Stars - ${_seasonController.episodeModel.value.name}'),
            Text(
              '${_detailsController.tvDetail.value.name} [S${_seasonController.seasonModel.value.seasonNumber.toString().padLeft(2, '0')} | E${_seasonController.episodeModel.value.episodeNumber.toString().padLeft(2, '0')}]',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Text(
                  '${_seasonController.episodeModel.value.guestStars == null ? 0 : _seasonController.episodeModel.value.guestStars!.length} Persons',
                  style: TextStyle(
                    color: primaryDarkBlue.withOpacity(0.7),
                    fontSize: n,
                  ),
                ),
              ),
              ListView.separated(
                itemCount: _seasonController.episodeModel.value.guestStars ==
                        null
                    ? 0
                    : _seasonController.episodeModel.value.guestStars!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  SeasonCrew cast =
                      _seasonController.episodeModel.value.guestStars![index];

                  return InkWell(
                    onTap: () {
                      _peopleController.setPersonId(cast.id!);
                      Get.toNamed('/people_details');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: cast.profilePath == null ||
                                    cast.profilePath == ""
                                ? avatarBuilder()
                                : CachedNetworkImage(
                                    height: 68,
                                    width: 68,
                                    imageUrl:
                                        '${_configurationController.posterUrl}${cast.profilePath}',
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
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cast.name ?? "name",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: m - 4,
                                    color: primaryDarkBlue.withOpacity(0.7),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  cast.character ?? "character",
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
          ),
        ),
      ),
    );
  }
}
